import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';
import 'package:firebase_chat_app/features/chat/domain/repositories/chat_repository.dart';

class WatchMessages {
  final ChatRepository chatRepository;
  WatchMessages(this.chatRepository);

  Stream<List<Message>> call(String chatID){
    return chatRepository.watchMessages(chatID);
  }

}