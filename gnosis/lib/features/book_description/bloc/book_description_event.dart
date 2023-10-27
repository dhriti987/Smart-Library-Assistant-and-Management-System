part of 'book_description_bloc.dart';

@immutable
sealed class BookDescriptionEvent {}

class ReadBookButtonClickedEvent extends BookDescriptionEvent {
  final BookModel book;

  ReadBookButtonClickedEvent({required this.book});
}