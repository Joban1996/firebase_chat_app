import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/send_message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_messages.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/sign_up_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/chat_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/sign_up_scren.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat_app/core/di/injection.dart';
import 'package:firebase_chat_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/screens/splash.dart';
import 'features/chat/data/data_sources/chat_data_source.dart';
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
  await ensureSignedIn();
  runApp(MaterialApp(
      home: MultiBlocProvider(providers: [
        //BlocProvider<ChatBloc>(create: (_)=> getIt<ChatBloc>()..add(ChatStarted()),child: ChatPage()),
        BlocProvider<SignUpBloc>(create: (_)=> getIt<SignUpBloc>())
      ], child: SignUpScreen())));
}
