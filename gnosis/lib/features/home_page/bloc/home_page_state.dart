part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

abstract class HomePageActionState extends HomePageState {}

final class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageSuccessState extends HomePageState {
  final List<BookModel> recommendedBooks;
  final List<BookModel> topRatedBooks;

  HomePageSuccessState(
      {required this.recommendedBooks, required this.topRatedBooks});
}

class HomePageToBookDescriptionPageActionState extends HomePageActionState {
  final BookModel book;

  HomePageToBookDescriptionPageActionState({required this.book});
}
