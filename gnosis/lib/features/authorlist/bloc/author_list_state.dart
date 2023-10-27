part of 'author_list_bloc.dart';

@immutable
sealed class AuthorListState {}

sealed class AuthorListActionState extends AuthorListState{}

final class AuthorListInitial extends AuthorListState {}

final class AuthorListLoadingState extends AuthorListState {}

class AuthorListSuccessState extends AuthorListState{
  final List<AuthorModel> authorList;

  AuthorListSuccessState({required this.authorList});
}

class AuthorListErrorState extends AuthorListState {}

class DisplayAuthorDetailActionState extends AuthorListActionState{
  final AuthorModel author;

  DisplayAuthorDetailActionState({required this.author});
}