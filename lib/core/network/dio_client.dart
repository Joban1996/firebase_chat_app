import 'package:dio/dio.dart';

import '../constant/constants.dart';
import '../storage/secure_storage_utils.dart';

class DioClient {

  final Dio dio;

  DioClient() : dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com/',
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 15),
    headers: {'Accept':'application/json'}
  )){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options,handler) async{
        if (options.extra['requiresAuth'] == true) {
          final token = await SecureStorageUtils().readSecureData(prefToken);
          options.headers['Authorization'] = 'Bearer ${token ?? ''}';
        }
        return handler.next(options);
      },
      onResponse: (response, handler){
        handler.next(response);
    },
      onError: (DioException error,handler){
        handler.next(error);
      }
    ));
  }
}