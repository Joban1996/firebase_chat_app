import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';

class ChatDataSource {
  final FirebaseFirestore firebaseFirestore;
  ChatDataSource(this.firebaseFirestore);

  Future<void> sendMessage(MessageModel message) {
    return firebaseFirestore.collection('messages').add(message.toMap());
  }

  Stream<List<MessageModel>> watchMessages() {
    return firebaseFirestore
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<UserModel>> watchUsers() {
    return firebaseFirestore
        .collection('users')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }

}