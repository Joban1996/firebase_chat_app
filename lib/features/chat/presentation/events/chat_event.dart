import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';

abstract class ChatEvent {}

class ChatStarted extends ChatEvent{}

class ChatMessageUpdated extends ChatEvent{
  final List<Message> messages;
  ChatMessageUpdated(this.messages);
}

class ChatMessageSent extends ChatEvent{
  final String text;
  final String senderId;
  ChatMessageSent(this.text,this.senderId);
}

