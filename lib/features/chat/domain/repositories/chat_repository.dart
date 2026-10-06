import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/data/model/user_model.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Stream<List<Message>> watchMessages(String chatID);
  Future<void> sendMessage(Message message);
  Stream<List<UserModel>> watchUsers();
}