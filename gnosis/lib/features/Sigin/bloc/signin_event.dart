part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class SignInButtonClickedEvent extends SigninEvent{}

class ForgotPasswordClickedEvent extends SigninEvent{}
