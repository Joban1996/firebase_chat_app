import 'dart:async';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/send_message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_messages.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_users.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/chat_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  final WatchMessages watchMessages;
  final SendMessage sendMessage;
  final WatchUsers watchUsers;
  StreamSubscription<List<Message>>? _messagesSubscription;
  ChatBloc({required this.watchMessages,required this.sendMessage,
    required this.watchUsers}):super(ChatLoading()){
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
      watchUsers(),
      onData: (users) {
        print('Users received: ${users.length}');
        return ChatUsersLoaded(users);
      },
    );
  }

  void _onChatStarted(ChatStarted event, Emitter<ChatState> emit) {
    _messagesSubscription?.cancel();
    _messagesSubscription = watchMessages(event.chatId).listen(
          (messages) => add(ChatMessageUpdated(messages)),
    );
  }

  void _onMessagesUpdated(ChatMessageUpdated event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.messages));
  }

  Future<void> _onMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    final message = Message(
      id: '',
      senderId: event.senderId,
      text: event.text,
      timeStamp: DateTime.now(), chatId: event.chatId,
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