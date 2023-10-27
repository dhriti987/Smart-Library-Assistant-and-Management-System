part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchTextFieldSubmitEvent extends SearchEvent {
  final String searchQuery;

  SearchTextFieldSubmitEvent({required this.searchQuery});
}

class SearchMicButtonOnClickedEvent extends SearchEvent {}

class SearchMicStateChangeEvent extends SearchEvent {}

class MicInputQueryResolveSearchEvent extends SearchEvent {
  final String searchQuery;

  MicInputQueryResolveSearchEvent({required this.searchQuery});
}