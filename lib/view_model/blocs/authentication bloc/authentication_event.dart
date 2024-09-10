part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class CheckLoginStatusEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthenticationEvent {
  final UserModel user;
  final String password;
  SignUpEvent({
    required this.user,
    required this.password,
  });
}

class SignInWithGoogleEvent extends AuthenticationEvent {}

class VerifyEmailEvent extends AuthenticationEvent {
  final BuildContext context;
  
  VerifyEmailEvent( {required this.context});
}

class ForgotPasswordEvent extends AuthenticationEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}
