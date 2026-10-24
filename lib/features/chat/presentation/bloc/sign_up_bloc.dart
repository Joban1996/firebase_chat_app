import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/chat/presentation/events/sign_up_event.dart';
import 'package:firebase_chat_app/features/chat/presentation/states/sign_up_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/notification_service.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  FirebaseAuth auth;
  FirebaseFirestore firebaseFirestore;
  SignUpBloc(this.auth,this.firebaseFirestore): super(SignUpLoading()){
    on<SignUpHit>(onSignUpHit);
  }

  Future<void> onSignUpHit(SignUpHit event,Emitter<SignUpState> emit)async {
        emit(SignUpLoading());

        try{
       final credentials = await  auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
       final user = credentials.user;

       if(user != null) {
         await firebaseFirestore.collection('users').doc(user.uid).set({
           'uid':user.uid,
           'email':user.email,
           'name':event.name,
           'createdAt': FieldValue.serverTimestamp()
         });
         try {
          final settings =  await getIt<NotificationService>().initialize();
          await getIt<NotificationService>().saveToken();
          print('Notification status: ${settings.authorizationStatus}');
         } catch (e) {
           debugPrint('Notification setup failed: $e');
         }
         emit(SignUpSuccess(user));
       }else{
         emit(SignUpFailure("User Creation Failed!"));
       }
        }on FirebaseAuthException catch(e){
          emit(SignUpFailure(e.message??"SignUp Failed!"));
        }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


}