// lib/features/chat/data/models/message_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/message.dart';

class MessageModel extends Message {
   MessageModel({
    required super.id,
    required super.senderId,
    required super.text,
    required super.timeStamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String documentId) {
    return MessageModel(
      id: documentId,
      senderId: map['senderId'] as String,
      text: map['text'] as String,
      timeStamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': Timestamp.fromDate(timeStamp),
    };
  }
}