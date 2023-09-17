import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/features/Sigin/repository/sign_in_repo.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SignInRepository signInRepository = sl.get<SignInRepository>();
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignInButtonClickedEvent>(signinButtonClickedEvent);
    on<ForgotPasswordClickedEvent>(forgotPasswordClickedEvent);
  }

  FutureOr<void> signinButtonClickedEvent(
      SignInButtonClickedEvent event, Emitter<SigninState> emit) async {
    // ### validate email and password
    try {
      await signInRepository.signIn(event.email, event.password);
      emit(SigninToHomePageActionState());
    } on ApiException {
      emit(SigninErrorState());
    }
  }

  FutureOr<void> forgotPasswordClickedEvent(
      ForgotPasswordClickedEvent event, Emitter<SigninState> emit) {
    emit(SigninToForgotPasswordPageActionState());
  }
}
