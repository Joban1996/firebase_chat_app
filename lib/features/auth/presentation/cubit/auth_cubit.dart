import 'package:flutter_base_architecture/features/auth/data/repositories/auth_repositories.dart';
import 'package:flutter_base_architecture/features/auth/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<LoginState>{

  final AuthRepositories authRepositories;
  AuthCubit(this.authRepositories): super(LoginLoading());

  Future<void> hitLogin(String email,String password)async{
    emit(LoginLoading());

    try {
      var data = await authRepositories.login(email, password);
      emit(LoginLoaded(data));
    }catch(e){
      emit(LoginError(e.toString()));
    }

  }

}