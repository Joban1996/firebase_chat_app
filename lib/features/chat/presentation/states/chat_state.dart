import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/data/model/user_model.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';

abstract class ChatState extends Equatable{

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState{}

class ChatUsersLoaded extends ChatState {
  final List<UserModel> users;

  ChatUsersLoaded(this.users);
}

class ChatLoaded extends ChatState{
  final List<Message> messages;
  ChatLoaded(this.messages);
  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState{
  final String error;
  ChatError(this.error);
  @override
  List<Object?> get props => [error];
}



