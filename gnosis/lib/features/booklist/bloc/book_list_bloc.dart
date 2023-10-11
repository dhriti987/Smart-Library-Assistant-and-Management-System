import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:meta/meta.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  BookListBloc() : super(BookListInitial()) {
    on<BookListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<BookListElementClickedEvent>(bookListElementClickedEvent);
  }

  FutureOr<void> bookListElementClickedEvent(
      BookListElementClickedEvent event, Emitter<BookListState> emit) {
    emit(BookListPageToBookDescriptionPageActionState(book: event.book));
  }
}
