import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/core/utils/size_utils.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/widgets/select_user_for_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/chat_bloc.dart';
import '../events/chat_event.dart';
import '../states/chat_state.dart';
import 'chat_page.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('ChatListScreen build called');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(onPressed: (){
              showDialog(context: context, builder: (context){
                return Dialog(
                    child: SelectUserForGroup());
              });
          },
              icon: Icon(Icons.group_add))
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          print('BlocBuilder state: ${state.runtimeType}');
          if (state is ChatUsersLoaded) {
            print('UI groups: ${state.groups.length}');
            return ListView.builder(
              itemCount: state.groups.isNotEmpty ?
              state.users.length+state.groups.length+2: state.users.length,
              itemBuilder: (context, index) {
               if(state.groups.isNotEmpty){

                if(index == 0){
                  return Text('Groups');
                }
                if(index <= state.groups.length){
                  final group = state.groups[index-1];
                  return ListTile(
                    title: Text(group.name.isNotEmpty?group.name:'Anonymous'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => getIt<ChatBloc>()
                              ..add(ChatStarted(group.id)),
                            child: ChatPage(chatId: group.id,
                              username: group.name,users: state.users,groupMembers: group.members,),
                          ),
                        ),
                      );
                    },
                  );
                }
                if(index == state.groups.length+1){
                  return Text('People');
                }
                final user = state.users[index - state.groups.length - 2];
                return ListTile(
                  title: Text(user.name.isNotEmpty?user.name:'Anonymous'),
                  onTap: () {
                    final currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
                    var chatId = context.read<ChatBloc>().createChatId(currentUserID, user.uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => getIt<ChatBloc>()
                            ..add(ChatStarted(chatId)),
                          child: ChatPage(chatId: chatId,username: user.name),
                        ),
                      ),
                    );
                  },
                );
              }else{
                 final user = state.users[index];
                 return ListTile(
                   title: Text(user.name.isNotEmpty?user.name:'Anonymous'),
                   onTap: () {
                     final currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
                     var chatId = context.read<ChatBloc>().createChatId(currentUserID, user.uid);
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => BlocProvider(
                           create: (_) => getIt<ChatBloc>()
                             ..add(ChatStarted(chatId)),
                           child: ChatPage(chatId: chatId,username: user.name),
                         ),
                       ),
                     );
                   },
                 );
               }
              }
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}