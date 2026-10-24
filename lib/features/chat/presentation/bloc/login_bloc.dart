
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/notification_service.dart';
import '../events/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth auth;

  LoginBloc(this.auth) : super(LoginLoading()) {
    on<LoginHit>(onLoginHit);
  }

  Future<void> onLoginHit(
      LoginHit event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password,
      );

      final user = credentials.user;

      if (user != null) {
        try {
          await getIt<NotificationService>().saveToken();
        } catch (e) {
          debugPrint('Notification setup failed: $e');
        }
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure('Login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message ?? 'Login failed.'));
    } catch (_) {
      emit(LoginFailure('Something went wrong. Please try again.'));
    }
  }
}
