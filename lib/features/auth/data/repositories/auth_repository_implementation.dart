import 'package:flutter_base_architecture/core/storage/secure_storage_utils.dart';
import 'package:flutter_base_architecture/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:flutter_base_architecture/features/auth/data/models/login_model.dart';
import 'package:flutter_base_architecture/features/auth/data/repositories/auth_repositories.dart';

class AuthRepositoryImplementation implements AuthRepositories {
  final AuthRemoteDatasource authRemoteDatasource;
  final SecureStorageUtils secureStorageUtils;

  AuthRepositoryImplementation(this.authRemoteDatasource,this.secureStorageUtils);

  @override
  Future<LoginResponseModel> login(String email, String password) async{
    var request = LoginRequestModel(email: email, password: password);
    var response = await authRemoteDatasource.login(request);
  
    await secureStorageUtils.writeSecureData('token', response.token);
    return response;

  }


}