import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_reader_event.dart';
part 'book_reader_state.dart';

class BookReaderBloc extends Bloc<BookReaderEvent, BookReaderState> {
  BookReaderBloc() : super(BookReaderInitial()) {
    on<BookReaderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
