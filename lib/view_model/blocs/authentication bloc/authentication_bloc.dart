import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/services/repositories/auth/auth_repository.dart';
import 'package:wave_learning_app/model/user_model.dart';
import 'package:wave_learning_app/view/screens/common_screens/custom_bottom_navigation_bar.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthRepository authRepository = AuthRepository();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignUpEvent>(signUpEvent);
    on<LoginEvent>(loginEvent);
    on<SignInWithGoogleEvent>(signInWithGoogleEvent);
    on<CheckLoginStatusEvent>(checkLoginStatusEvent);
    on<VerifyEmailEvent>(verifyEmailEvent);
    on<ForgotPasswordEvent>(forgotPasswordEvent);
  }

  FutureOr<void> signUpEvent(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await authRepository.signUpWithEmailAndPassword(
          event.user, event.password);
      if (user != null) {
        authRepository.addUserToDatabase(event.user.userName.toString());
        _auth.currentUser!.sendEmailVerification();
        emit(AuthenticatedState(user));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(error: e.toString()));
    }
  }

  FutureOr<void> loginEvent(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await authRepository.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        emit(AuthenticatedState(user));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(error: e.toString()));
    }
  }

  FutureOr<void> signInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    if (!kIsWeb) {
      emit(AuthLoadingState());
    }

    try {
      final user = await authRepository.signInWithGoogle();
      if (user != null) {
        await authRepository.saveGoogleUserToDatabase();
        emit(SignInWithGooglestate(user));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      log('error:$e');
      emit(AuthErrorState(error: e.toString()));
    }
  }

  FutureOr<void> checkLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<AuthenticationState> emit) {
    try {
      final user = authRepository.checkLoginStatus();
      if (user != null && _auth.currentUser!.emailVerified) {
        emit(AuthenticatedState(user));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      log('error$e');
      emit(AuthErrorState(error: e.toString()));
    }
  }

  FutureOr<void> verifyEmailEvent(
      VerifyEmailEvent event, Emitter<AuthenticationState> emit) async {
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      Navigator.of(event.context).pushReplacement(
          MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()));
    } else {
      ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text('error: Please conform your email')));
    }
  }

  FutureOr<void> forgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await authRepository.forgotPassword(event.email);
      emit(ForgotPasswordLinkSendedState());
    } catch (e) {
      log('$e');
    }
  }
}
