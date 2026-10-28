import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/core/di/injection.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/group.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/create_group.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/send_message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_groups.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_messages.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_users.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/chat_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/user.dart' as userModel;

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  final WatchMessages watchMessages;
  final SendMessage sendMessage;
  final WatchUsers watchUsers;
  final WatchGroups watchGroups;
  final FirebaseAuth auth;
  final CreateGroupUseCase createGroupUseCase;
  StreamSubscription<List<Message>>? _messagesSubscription;

  final Set<String> _knownMessageIds = {};
  bool _isInitialMessageLoad = true;


  ChatBloc({required this.watchMessages,required this.sendMessage,
    required this.watchUsers,required this.auth,
     required this.createGroupUseCase, required this.watchGroups,}):super(ChatLoading()){
    print('ChatBloc constructed: ${identityHashCode(this)}');
    on<ChatStarted>(_onChatStarted);
    on<ChatMessageUpdated>(_onMessagesUpdated);
    on<ChatMessageSent>(_onMessageSent);
    on<CreateGroup>(_createAGroup);
    on<ChatListStarted>(_chatListData);
  }

  Future<void> _chatListData(ChatListStarted event,Emitter<ChatState> emit)async{
    print('HANDLER FILE: chat_bloc.dart');
    print('HANDLER INSTANCE: ${identityHashCode(this)}');
    final userId = getIt<FirebaseAuth>().currentUser!.uid;
    await emit.forEach(
      Rx.combineLatest2(
        watchUsers.call(),
        watchGroups.call(userId),
            (users, groups) {
              print('Combined groups: ${groups.length}');
             return ChatUsersLoaded(
                users.cast<userModel.User>(),
                groups.cast<Group>(),
              );
            }
      ),
      onData: (state) {
        print('Emitting state: ${(state).groups.length}');
        return state;
      },
    );
  }

  void _onChatStarted(ChatStarted event, Emitter<ChatState> emit) {
    _messagesSubscription?.cancel();

    _knownMessageIds.clear();
    _isInitialMessageLoad = true;

    _messagesSubscription = watchMessages(event.chatId).listen(
          (messages) => add(ChatMessageUpdated(messages)),
    );
  }

  void _onMessagesUpdated(ChatMessageUpdated event, Emitter<ChatState> emit) async{
    final currentUserId = auth.currentUser?.uid;

    if (_isInitialMessageLoad) {
      _knownMessageIds.addAll(
        event.messages.map((message) => message.id),
      );

      _isInitialMessageLoad = false;
    } else {
      for (final message in event.messages) {
        if (_knownMessageIds.add(message.id) &&
            message.senderId != currentUserId &&
            currentUserId != null) {
          debugPrint(message.text);
          // await localNotificationService.showMessageNotification(
          //   senderName: 'New message',
          //   message: message.text,
          // );
        }
      }
    }
    emit(ChatLoaded(event.messages));
  }

  Future<void> _onMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    final message = Message(
      id: '',
      senderId: event.senderId,
      text: event.text,
      timeStamp: DateTime.now(),
      chatId: event.chatId,
    );
    await sendMessage(message);
  }

  //Create chatID
  String createChatId(String uid1, String uid2) {
    final ids = [uid1, uid2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  //Create a chat group
  void _createAGroup(CreateGroup event,Emitter<ChatState> emit)async{
    await createGroupUseCase.call(groupName: event.groupName, memberIds: event.memberIds, createdBy: event.currentUserId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }

}