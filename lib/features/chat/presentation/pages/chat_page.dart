import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/message_input_bar.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/message_list.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    return Scaffold(
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
                return BuildMessageList(state: state, currentUserID: currentUserId);
              }
              return Container();
            }),
          ),
          MessageInputBar(currentUserId: currentUserId)
        ],
      ),
    );
  }
}
