part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageInitailEvent extends HomePageEvent {}

class BookVarietyButtonClickedEvent extends HomePageEvent {}

class BookHeadingTextClickedEvent extends HomePageEvent {}

class BookImageClickedEvent extends HomePageEvent {
  final BookModel book;

  BookImageClickedEvent({required this.book});
}
