part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class AuthLoadingState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final User? user;
  AuthenticatedState(this.user);
}

class UnAuthenticatedState extends AuthenticationState {}

class AuthErrorState extends AuthenticationState {
  final String error;

  AuthErrorState({required this.error});
}

class EmailVerifiedState extends AuthenticationState {}

class EmailVerifyErrorState extends AuthenticationState {}

class ForgotPasswordLinkSendedState extends AuthenticationState {}

class SignInWithGooglestate extends AuthenticationState {
  final User? user;
  SignInWithGooglestate(this.user);
}
