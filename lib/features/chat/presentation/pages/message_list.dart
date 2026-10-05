import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/material.dart';

class BuildMessageList extends StatelessWidget {
  const BuildMessageList({super.key, required this.state, required this.currentUserID});
  final ChatLoaded state;
  final String currentUserID;

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
        final message = reversedMessages[index];
        var isMe = message.senderId == currentUserID;
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message.text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
          ),
        );
        ;
      },
    );
  }
}
