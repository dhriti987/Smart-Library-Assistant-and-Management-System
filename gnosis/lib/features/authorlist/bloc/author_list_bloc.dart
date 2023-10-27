import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/models/author_model.dart';
import 'package:meta/meta.dart';

part 'author_list_event.dart';
part 'author_list_state.dart';

class AuthorListBloc extends Bloc<AuthorListEvent, AuthorListState> {
  AuthorListBloc() : super(AuthorListInitial()) {
    on<AuthorListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AuthorListFetchEvent>(authorListFetchEvent);
    on<AuthorOnCLickedEvent>(authorOnCLickedEvent);
  }

  FutureOr<void> authorListFetchEvent(AuthorListFetchEvent event, Emitter<AuthorListState> emit) {
  }

  FutureOr<void> authorOnCLickedEvent(AuthorOnCLickedEvent event, Emitter<AuthorListState> emit) {
    emit(DisplayAuthorDetailActionState(author: event.author));
  }
}
