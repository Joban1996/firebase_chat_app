import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/data/model/group_model.dart';
import '../../../../core/di/injection.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';

class ChatDataSource {
  ChatDataSource();

  Future<void> sendMessage(MessageModel message) {
    return getIt<FirebaseFirestore>().collection('messages').add(message.toMap());
  }


  Stream<List<MessageModel>> watchMessages(String chatId) {
    print('Watching messages for chatId: $chatId');
    return getIt<FirebaseFirestore>()
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      print('Documents received: ${snapshot.docs.length}');
      for (final doc in snapshot.docs) {
        print('Message document: ${doc.data()}');
      }
      return snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }


  Stream<List<UserModel>> watchUsers() {
    final currentUserId = getIt.call<FirebaseAuth>().currentUser!.uid;
    return getIt<FirebaseFirestore>()
        .collection('users')
        .where('uid',isNotEqualTo: currentUserId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }

  Future<String> createGroup({String? groupName,List<String>? memberIds,String? currentUserID})async{
    final chatRef = getIt<FirebaseFirestore>().collection('chats').doc();

    final members = {...memberIds!,currentUserID}.toList();

    await chatRef.set({
      'name': groupName,
      'type': 'group',
      'members': members,
      'createdBy': currentUserID,
      'createdAt': FieldValue.serverTimestamp()
    });
   return chatRef.id;

  }

Stream<List<GroupModel>> watchGroups(String userId) {
  print('watchGroups called');
  return getIt<FirebaseFirestore>()
      .collection('chats')
      .where('members', arrayContains: userId)
      .where('type', isEqualTo: 'group')
      .snapshots()
      .map((snapshot) {
    print('Firestore groups count: ${snapshot.docs.length}');
    return snapshot.docs
        .map((doc) => GroupModel.fromMap(doc.data(), doc.id))
        .toList();
  });
}



}