import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  User user;
  SignUpSuccess(this.user);
}

class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure(this.message);
}