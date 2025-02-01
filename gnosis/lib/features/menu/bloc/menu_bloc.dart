import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LogoutMenuEvent>(logoutMenuEvent);
  }

  FutureOr<void> logoutMenuEvent(LogoutMenuEvent event, Emitter<MenuState> emit) async{
    SharedPreferences preferences = sl.get<SharedPreferences>();
    await preferences.clear();
    emit(GoToSignInPageMenuActionState());
  }
}
