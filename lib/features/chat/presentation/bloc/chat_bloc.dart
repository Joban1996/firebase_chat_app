import 'dart:async';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/send_message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_messages.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_users.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/chat_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/local_notification_service.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  final WatchMessages watchMessages;
  final SendMessage sendMessage;
  final WatchUsers watchUsers;
  final FirebaseAuth auth;
  final LocalNotificationService localNotificationService;
  StreamSubscription<List<Message>>? _messagesSubscription;

  final Set<String> _knownMessageIds = {};
  bool _isInitialMessageLoad = true;

  ChatBloc({required this.watchMessages,required this.sendMessage,
    required this.watchUsers,required this.auth,
    required this.localNotificationService,}):super(ChatLoading()){
    on<ChatStarted>(_onChatStarted);
    on<ChatMessageUpdated>(_onMessagesUpdated);
    on<ChatMessageSent>(_onMessageSent);
    on<UsersStarted>(_watchUsers);
  }

  Future<void> _watchUsers(
      UsersStarted event,
      Emitter<ChatState> emit,
      ) async {
    print('UsersStarted received');

    await emit.forEach(
      watchUsers.call(),
      onData: (users) {
        print('Users received: ${users.length}');
        return ChatUsersLoaded(users);
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
          await localNotificationService.showMessageNotification(
            senderName: 'New message',
            message: message.text,
          );
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

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }

}