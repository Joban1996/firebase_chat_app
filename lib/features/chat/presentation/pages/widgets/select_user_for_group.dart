import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:firebase_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SelectUserForGroup extends StatelessWidget {
  const SelectUserForGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hint: Text('Group name'),border: OutlineInputBorder()),
        ),
        BlocBuilder<ChatBloc,ChatState>(builder: (context,state){
          if(state is ChatUsersLoaded){
            if(state.users.isEmpty){
              return Center(child: Text('Users not found..'),);
            }
            return ListView.builder(itemBuilder: (context,index){
              return ListTile(title: Text(state.users[index].name.isNotEmpty?
              state.users[index].name:'Anonymous'),

              );
            });
          }
          return Container();
        }),
        ElevatedButton(onPressed: (){},
            child: Text("Create"))
      ],
    );
  }
}
