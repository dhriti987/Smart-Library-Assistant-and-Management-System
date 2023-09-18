part of 'book_list_bloc.dart';

@immutable
abstract class BookListState {}

abstract class BookListActionState extends BookListState {}

final class BookListInitial extends BookListState {}

class BookListSuccessState extends BookListState {
  final List<BookModel> book;

  BookListSuccessState({required this.book});
}

class BookListPageToBookDescriptionPageActionState extends BookListActionState {
  final BookModel book;

  BookListPageToBookDescriptionPageActionState({required this.book});
}
