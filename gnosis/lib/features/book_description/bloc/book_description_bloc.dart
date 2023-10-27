import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:meta/meta.dart';

part 'book_description_event.dart';
part 'book_description_state.dart';

class BookDescriptionBloc extends Bloc<BookDescriptionEvent, BookDescriptionState> {
  BookDescriptionBloc() : super(BookDescriptionInitial()) {
    on<BookDescriptionEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ReadBookButtonClickedEvent>(readBookButtonClickedEvent);
  }

  FutureOr<void> readBookButtonClickedEvent(ReadBookButtonClickedEvent event, Emitter<BookDescriptionState> emit) {
    emit(NavigateToBookReadPage(book: event.book));
  }
}
