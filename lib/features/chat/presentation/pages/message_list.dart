import 'package:firebase_chat_app/core/utils/size_utils.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/user.dart';

class BuildMessageList extends StatelessWidget {
  const BuildMessageList({super.key, required this.state, required this.currentUserID, required this.users});
  final ChatLoaded state;
  final String currentUserID;
  final List<User>? users;

  @override
  Widget build(BuildContext context) {
    if (state.messages.isEmpty) {
      return const Center(child: Text('No messages yet'));
    }

    final reversedMessages = state.messages.reversed.toList();
    return  ListView.builder(
      reverse: true,
      itemCount: reversedMessages.length,
      itemBuilder: (context, index) {
       List<String>? userName = users?.reversed.where((val)=> val.uid ==
           state.messages.reversed.toList()[index].senderId)
           .map((val)=>val.name).toList();
        final message = reversedMessages[index];
        var isMe = message.senderId == currentUserID;
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            !isMe ? userName!=null ? Text(
                userName.first,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.black,fontSize: 12
                ),
              ).paddingOnly(left: 8): SizedBox(): SizedBox(),
              Container(
                margin: EdgeInsets.only(right: 8,left: 8,bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: Radius.circular(isMe ? 12 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 12),
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          )
        );
        ;
      },
    );
  }
}
