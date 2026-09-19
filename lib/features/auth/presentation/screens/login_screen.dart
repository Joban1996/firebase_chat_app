import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height -
                  MediaQuery.paddingOf(context).top -
                  MediaQuery.paddingOf(context).bottom,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.0,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hint: Text('Email')),
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(hint: Text('Password')),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          context.read<AuthCubit>().hitLogin(emailController.text, passwordController.text);
                        },
                        child: Text('Login'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
