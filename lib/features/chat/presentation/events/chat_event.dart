import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';

abstract class ChatEvent {}

class ChatStarted extends ChatEvent{
  final String chatId;
  ChatStarted(this.chatId);
}

class UsersStarted extends ChatEvent {}

class UsersLoaded extends ChatEvent{
  final List<User> users;
  UsersLoaded(this.users);
}

class ChatMessageUpdated extends ChatEvent{
  final List<Message> messages;
  ChatMessageUpdated(this.messages);
}

class ChatMessageSent extends ChatEvent{
  final String text;
  final String senderId;
  ChatMessageSent(this.text,this.senderId);
}

