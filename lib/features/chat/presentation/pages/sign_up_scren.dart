import 'package:firebase_chat_app/features/chat/presentation/bloc/sign_up_bloc.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/sign_up_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_list_screen.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc,SignUpState>(listener: (context,state){
        if(state is SignUpSuccess){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> ChatListScreen()));
        }
        if(state is SignUpFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
    },child: Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                context.read<SignUpBloc>().add(SignUpHit(emailController.text.trim(), passwordController.text.trim()));
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    ),);
  }
}