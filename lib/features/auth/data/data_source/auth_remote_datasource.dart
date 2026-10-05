import 'package:dio/dio.dart';
import 'package:firebase_chat_app/core/network/dio_client.dart';
import 'package:firebase_chat_app/core/network/handle_dio_error.dart';

import '../models/login_model.dart';

class AuthRemoteDatasource {
  final DioClient dioClient;
  AuthRemoteDatasource(this.dioClient);


  Future<LoginResponseModel> login(LoginRequestModel request)async{
    try {
      var response = await dioClient.dio.post('/api/login', data: request.toJson());
      var parsedRes = LoginResponseModel.fromJson(response.data);

      return parsedRes;
    }on DioException catch(e){
       throw handleDioError(e);
    }
  }

}