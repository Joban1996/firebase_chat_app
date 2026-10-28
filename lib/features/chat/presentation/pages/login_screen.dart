
import 'package:firebase_chat_app/features/chat/presentation/pages/sign_up_scren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/login_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/login_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/login_state.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_list_screen.dart';

import '../../../../core/di/injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatListScreen(),
                ),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                        LoginHit(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        ),
                      );
                    },
                    child:  const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> SignUpScreen())),
                      child: Text("Go to Signup",style: TextStyle(color: Colors.blue),))
                ],
              ),
            );
          },
        ),
      );
  }
}
