part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

abstract class SigninActionState extends SigninState{}

final class SigninInitial extends SigninState {}

class SigninSuccessState extends SigninState{}

class ForgotPasswordState extends SigninState{}

class SigninErrorState extends SigninState{}

class SigninToHomePageActionState extends SigninActionState{}

class SigninToForgotPasswordPageActionState extends SigninActionState{}