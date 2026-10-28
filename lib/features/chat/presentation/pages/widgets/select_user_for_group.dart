import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/core/di/injection.dart';
import 'package:firebase_chat_app/core/utils/size_utils.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/chat_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SelectUserForGroup extends StatefulWidget {
   const SelectUserForGroup({super.key});

  @override
  State<SelectUserForGroup> createState() => _SelectUserForGroupState();
}

class _SelectUserForGroupState extends State<SelectUserForGroup> {
   final Set<String> selectedIds = {};
   final TextEditingController controller = TextEditingController();
   late String currentUserId = '';

  @override
  Widget build(BuildContext context) {
    print(
      'SelectUserForGroup BLoC: '
          '${identityHashCode(context.read<ChatBloc>())}',
    );
    return SizedBox(
        height: context.screenHeight/2,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  hint: Text('Group name'),border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24)
              )),
            ).paddingAll(4),
            Expanded(
              child: BlocBuilder<ChatBloc,ChatState>(builder: (context,state){
                if(state is ChatUsersLoaded){
                  if(state.users.isEmpty){
                    return Center(child: Text('Users not found..'),);
                  }
                  return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context,index){
                    return ListTile(title: Text(state.users[index].name.isNotEmpty?
                    state.users[index].name:'Anonymous'),
                      trailing: Checkbox(
                          value: selectedIds.contains(state.users[index].uid),
                          onChanged:(val){
                            if(val == true){
                              selectedIds.add(state.users[index].uid);
                            }else{
                              selectedIds.remove(state.users[index].uid);
                            }
                            setState(() {});
                            }
                      )
                    );
                  });
                }
                return Container();
              }),
            ),
            ElevatedButton(
                onPressed: ()async{
                  currentUserId = getIt<FirebaseAuth>().currentUser!.uid;
                  context.read<ChatBloc>().add(CreateGroup(controller.text.trim()
                      ,selectedIds.toList(), currentUserId));
                  Navigator.pop(context);
                },
                child: Text("Create")),
            SizedBox(height: 8,)
          ],
        ),
      );
  }
}
