
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/core/services/local_notification_service.dart';
import 'package:firebase_chat_app/core/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_chat_app/core/di/injection.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/login_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/sign_up_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/chat_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_list_screen.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/login_screen.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/sign_up_scren.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setUpLocator();
  await getIt<NotificationService>().initialize();
  await getIt<LocalNotificationService>().initialize();

  final user = getIt<FirebaseAuth>().currentUser;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<SignUpBloc>(
          create: (_) => getIt<SignUpBloc>(),
        ),
        BlocProvider<ChatBloc>(
          create: (_) {
            final bloc = getIt<ChatBloc>();
            print('Main BLoC: ${identityHashCode(bloc)}');

            bloc.add(ChatListStarted());
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
        home: user != null
            ? ChatListScreen()
            : LoginScreen(),
      ),
    ),
  );
}
