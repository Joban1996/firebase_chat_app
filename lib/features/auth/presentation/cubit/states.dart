import 'package:firebase_chat_app/features/auth/data/models/login_model.dart';

abstract class LoginState{}

class LoginLoading extends LoginState{}

class LoginLoaded extends LoginState{
  final LoginResponseModel response;
  LoginLoaded(this.response);
}

class LoginError extends LoginState{
  String error;
  LoginError(this.error);
}