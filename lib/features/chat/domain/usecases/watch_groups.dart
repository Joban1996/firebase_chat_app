import 'package:firebase_chat_app/features/chat/data/model/group_model.dart';
import 'package:firebase_chat_app/features/chat/domain/repositories/chat_repository.dart';

class WatchGroups {
  final ChatRepository chatRepository;

  WatchGroups(this.chatRepository);

  Stream<List<GroupModel>> call(String userID){
   return chatRepository.watchGroups(userID);
  }


}