import 'package:firebase_chat_app/features/auth/data/models/login_model.dart';

abstract class AuthRepositories {

  Future<LoginResponseModel> login(String email,String password);
}