part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState {}

final class HomeInitial extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomePageToMenuActionState extends HomeActionState {}

class HomePageToSearchActionState extends HomeActionState {}

class PageChangeState extends HomeState {
  final int pageIndex;

  PageChangeState({required this.pageIndex});
}
