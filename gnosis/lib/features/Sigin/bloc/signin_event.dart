part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class SignInButtonClickedEvent extends SigninEvent {
  final String email;
  final String password;

  SignInButtonClickedEvent({required this.email, required this.password});
}

class ForgotPasswordClickedEvent extends SigninEvent {}
