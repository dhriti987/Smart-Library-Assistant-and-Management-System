part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class SendOtpClickedEvent extends ForgotPasswordEvent{}

class LoginButtonClickedEvent extends ForgotPasswordEvent{}