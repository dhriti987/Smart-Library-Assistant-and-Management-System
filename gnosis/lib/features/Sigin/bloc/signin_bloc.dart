import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignInButtonClickedEvent>(signinButtonClickedEvent);
    on<ForgotPasswordClickedEvent>(forgotPasswordClickedEvent);
  }

  FutureOr<void> signinButtonClickedEvent(
      SignInButtonClickedEvent event, Emitter<SigninState> emit) {
    emit(SigninToHomePageActionState());
  }

  FutureOr<void> forgotPasswordClickedEvent(
      ForgotPasswordClickedEvent event, Emitter<SigninState> emit) {
    emit(SigninToForgotPasswordPageActionState());
  }
}
