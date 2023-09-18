part of 'book_list_bloc.dart';

@immutable
abstract class BookListEvent {}

class BookListElementClickedEvent extends BookListEvent {
  final BookModel book;

  BookListElementClickedEvent({required this.book});
}
