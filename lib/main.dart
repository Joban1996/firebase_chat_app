import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/sign_up_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_list_screen.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/sign_up_scren.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat_app/core/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/events/chat_event.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'firebase_options.dart';

Future<void> ensureSignedIn() async {
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setUpLocator();
  var user = getIt<FirebaseAuth>().currentUser;
 // await ensureSignedIn();
  runApp(MaterialApp(
      home:user != null ?
      BlocProvider<ChatBloc>(create: (_)=> getIt<ChatBloc>()..add(UsersStarted()), child: ChatListScreen())
          :
      BlocProvider<SignUpBloc>(create: (_)=> getIt<SignUpBloc>(),child: SignUpScreen())));
}

