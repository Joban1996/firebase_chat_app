import 'package:flutter_base_architecture/core/network/dio_client.dart';
import 'package:flutter_base_architecture/core/storage/secure_storage_utils.dart';
import 'package:flutter_base_architecture/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:flutter_base_architecture/features/auth/data/repositories/auth_repositories.dart';
import 'package:flutter_base_architecture/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';


final GetIt getIt = GetIt.instance;
Future<void> setUpLocator()async {
  getIt.registerLazySingleton<SecureStorageUtils>(()=>SecureStorageUtils());
  getIt.registerLazySingleton<DioClient>(()=>DioClient());
  getIt.registerLazySingleton<AuthRemoteDatasource>(()=>AuthRemoteDatasource(getIt<DioClient>()));
  getIt.registerLazySingleton<AuthRepositories>(()=>
      AuthRepositoryImplementation(getIt<AuthRemoteDatasource>(), getIt<SecureStorageUtils>()));
  getIt.registerLazySingleton<AuthCubit>(
        () => AuthCubit(getIt<AuthRepositories>()),
  );

}