import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/data/model/user_model.dart';

import '../repositories/chat_repository.dart';

class WatchUsers {
  final ChatRepository repository;

  WatchUsers(this.repository);

  Stream<List<UserModel>> call() {
    return repository.watchUsers();
  }
}