part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class MenuIconClickedEvent extends HomeEvent {}

class SearchIconClickedEvent extends HomeEvent {}

class BottomNavigationBarIconClickedEvent extends HomeEvent {
  final int pageIndex;

  BottomNavigationBarIconClickedEvent({required this.pageIndex});
}
