import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_description_event.dart';
part 'book_description_state.dart';

class BookDescriptionBloc extends Bloc<BookDescriptionEvent, BookDescriptionState> {
  BookDescriptionBloc() : super(BookDescriptionInitial()) {
    on<BookDescriptionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
