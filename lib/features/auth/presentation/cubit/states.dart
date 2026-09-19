import 'package:flutter_base_architecture/features/auth/data/models/login_model.dart';

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