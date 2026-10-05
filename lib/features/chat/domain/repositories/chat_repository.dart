import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Stream<List<Message>> watchMessages();
  Future<void> sendMessage(Message message);
}