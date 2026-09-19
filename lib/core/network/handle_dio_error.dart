import 'package:dio/dio.dart';

import 'exceptions.dart';

Exception handleDioError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return NetworkException('Connection timeout');
  }

  if (e.response != null) {
    final message = e.response?.data?['error'] ?? 'Something went wrong';
    return ServerException(message);
  }

  return NetworkException('No internet connection');
}