part of 'author_list_bloc.dart';

@immutable
sealed class AuthorListEvent {}

class AuthorListFetchEvent extends AuthorListEvent {}

class AuthorOnCLickedEvent extends AuthorListEvent {
  final AuthorModel author;

  AuthorOnCLickedEvent({required this.author});
}