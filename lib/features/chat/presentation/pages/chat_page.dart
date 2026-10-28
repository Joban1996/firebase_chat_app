
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/core/di/injection.dart';
import 'package:firebase_chat_app/core/utils/size_utils.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/group_info.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/message_input_bar.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/message_list.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart' as userModel;

class ChatPage extends StatelessWidget {
  const ChatPage({super.key,required this.chatId,required this.username, this.users,this.groupMembers});
  final String chatId;
  final String username;
  final List<userModel.User>? users;
  final List<String>? groupMembers;


  @override
  Widget build(BuildContext context) {
    final currentUserId = getIt<FirebaseAuth>().currentUser?.uid ?? '';
    final currentUserName = getIt<FirebaseAuth>().currentUser?.displayName ?? '';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: (){
                  if(users!=null && groupMembers!=null){
                    List<String>? names = [];
                    names.add('${capitalizeFirst(currentUserName)} (You)');
                    for(int j=0; j< users!.length;j++) {
                      if(groupMembers!.contains(users![j].uid)) {
                        names.add(users![j].name);
                      }
                    }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_)=> GroupInfo(groupMembers: names)));
                  }},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                      overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 17),
                    ),
                    groupMembers!=null ? Text("Members: ${groupMembers!.length}",
                      style: TextStyle(fontSize: 12),
                    ):SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc,ChatState>(builder: (context,state){
              if(state is ChatLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is ChatError){
                return Center(child: Text(state.error.toString()),);
              }
              if(state is ChatLoaded){
                return BuildMessageList(state: state, currentUserID: currentUserId, users: users,);
              }
              return Container();
            }),
          ),
          MessageInputBar(currentUserId: currentUserId,chatId: chatId)
        ],
      ),
    );
  }
}
