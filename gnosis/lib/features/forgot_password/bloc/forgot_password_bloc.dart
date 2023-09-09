import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordToHomePageActionState() as ForgotPasswordState);
  }
}
