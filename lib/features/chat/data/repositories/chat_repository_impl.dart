import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/data/data_sources/chat_data_source.dart';
import 'package:firebase_chat_app/features/chat/data/model/message_model.dart';
import 'package:firebase_chat_app/features/chat/data/model/user_model.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';
import 'package:firebase_chat_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository{
  final ChatDataSource chatDataSource;
  ChatRepositoryImpl(this.chatDataSource);

  @override
  Future<void> sendMessage(Message message) {
    final model =  MessageModel(id: message.id, senderId: message.senderId, text: message.text, timeStamp: message.timeStamp);
   return chatDataSource.sendMessage(model);
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    // TODO: implement watchMessages
    return chatDataSource.watchMessages();
  }

  @override
  Stream<List<UserModel>> watchUsers() {
    // TODO: implement watchUsers
    return chatDataSource.watchUsers();
  }


}