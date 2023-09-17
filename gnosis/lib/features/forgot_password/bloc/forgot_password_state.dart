part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

abstract class ForgotPasswordActionState{}

final class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState{}

class ForgotPasswordErrorState extends ForgotPasswordState{}

class ForgotPasswordToHomePageActionState extends ForgotPasswordActionState{}