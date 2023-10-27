part of 'search_bloc.dart';

@immutable
sealed class SearchState {}
sealed class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {}

class DisplayBookListResult extends SearchActionState {
  final String title;
  final Future<List<BookModel>> books;

  DisplayBookListResult({required this.title, required this.books});
}

class MicButtonClickedState extends SearchActionState {}
class MicStateChange extends SearchState {}

class DisplayBookListResultWithReply extends SearchActionState {
  final String title;
  final Future<List<BookModel>> books;
  final String reply;

  DisplayBookListResultWithReply({required this.title, required this.books, required this.reply});
}

class DisplayBookResultWithReply extends SearchActionState {
  final String title;
  final BookModel books;
  final String reply;

  DisplayBookResultWithReply({required this.title, required this.books, required this.reply});
}

class NoBookFoundStateWithReply extends SearchActionState {
  final String reply;

  NoBookFoundStateWithReply({required this.reply});
}