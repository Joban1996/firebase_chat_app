import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/core/network/dio_client.dart';
import 'package:firebase_chat_app/core/storage/secure_storage_utils.dart';
import 'package:firebase_chat_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:firebase_chat_app/features/auth/data/repositories/auth_repositories.dart';
import 'package:firebase_chat_app/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:firebase_chat_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/send_message.dart';
import 'package:firebase_chat_app/features/chat/domain/usecases/watch_messages.dart';
import 'package:firebase_chat_app/features/chat/presentation/bloc/sign_up_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/chat/data/data_sources/chat_data_source.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';


final GetIt getIt = GetIt.instance;
Future<void> setUpLocator()async {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  getIt.registerLazySingleton<SecureStorageUtils>(()=>SecureStorageUtils());
  getIt.registerLazySingleton<DioClient>(()=>DioClient());
  getIt.registerLazySingleton<AuthRemoteDatasource>(()=>AuthRemoteDatasource(getIt<DioClient>()));
  getIt.registerLazySingleton<AuthRepositories>(()=>
      AuthRepositoryImplementation(getIt<AuthRemoteDatasource>(), getIt<SecureStorageUtils>()));
  getIt.registerLazySingleton<AuthCubit>(
        () => AuthCubit(getIt<AuthRepositories>()),);
  getIt.registerLazySingleton<ChatDataSource>(()=>ChatDataSource(firebaseFirestore));
  getIt.registerLazySingleton<ChatRepositoryImpl>(()=>ChatRepositoryImpl(getIt<ChatDataSource>()));
  getIt.registerLazySingleton<WatchMessages>(()=>WatchMessages(getIt<ChatRepositoryImpl>()));
  getIt.registerLazySingleton<SendMessage>(()=>SendMessage(getIt<ChatRepositoryImpl>()));
  getIt.registerLazySingleton<ChatBloc>(()=>
      ChatBloc(watchMessages: getIt<WatchMessages>(), sendMessage: getIt<SendMessage>()));
  getIt.registerLazySingleton<SignUpBloc>(()=> SignUpBloc(firebaseAuth,firebaseFirestore));
}