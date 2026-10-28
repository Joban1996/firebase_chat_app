import 'package:firebase_chat_app/features/chat/data/model/group_model.dart';
import 'package:firebase_chat_app/features/chat/domain/repositories/chat_repository.dart';

class CreateGroupUseCase {
  final ChatRepository repository;
  CreateGroupUseCase(this.repository);

  Future<void> call({required String groupName, required List<String> memberIds, required String createdBy,}) {
    return repository.createGroup(
        GroupModel( name: groupName, members: memberIds, createdBy: createdBy, id: createdBy));
  }
}