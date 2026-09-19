import 'package:flutter_base_architecture/features/auth/data/models/login_model.dart';

abstract class AuthRepositories {

  Future<LoginResponseModel> login(String email,String password);
}