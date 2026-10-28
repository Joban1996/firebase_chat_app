import 'package:firebase_chat_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  const GroupInfo({super.key,this.groupMembers});
  final List<String>? groupMembers;

  @override
  Widget build(BuildContext context) {
    return groupMembers != null ? Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Group Members",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400)),
            Expanded(
              child: ListView.builder(
                  itemCount: groupMembers!.length,
                  itemBuilder: (context,index){
                  return Text(groupMembers![index]).paddingAll(8.0);
              }),
            ),
          ],
        ),
      ),
    ):Container();
  }
}
