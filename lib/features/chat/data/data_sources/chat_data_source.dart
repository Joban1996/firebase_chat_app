import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/di/injection.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';

class ChatDataSource {
  final FirebaseFirestore firebaseFirestore;
  ChatDataSource(this.firebaseFirestore);

  Future<void> sendMessage(MessageModel message) {
    return firebaseFirestore.collection('messages').add(message.toMap());
  }

  Stream<List<MessageModel>> watchMessages(String chatId) {
    return firebaseFirestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<UserModel>> watchUsers() {
    final currentUserId = getIt.call<FirebaseAuth>().currentUser!.uid;
    return firebaseFirestore
        .collection('users')
        .where('uid',isNotEqualTo: currentUserId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }

}