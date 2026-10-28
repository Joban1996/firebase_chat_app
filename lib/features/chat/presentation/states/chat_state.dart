import 'package:equatable/equatable.dart';
import 'package:firebase_chat_app/features/chat/domain/entities/message.dart';

import '../../domain/entities/group.dart';
import '../../domain/entities/user.dart';

abstract class ChatState extends Equatable{

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState{}

class ChatUsersLoaded extends ChatState {
  final List<User> users;
  final List<Group> groups;

  ChatUsersLoaded(this.users, this.groups);

  @override
  List<Object?> get props => [users, groups];
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





