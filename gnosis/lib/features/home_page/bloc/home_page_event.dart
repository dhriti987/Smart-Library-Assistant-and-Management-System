part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class BookVarietyButtonClickedEvent extends HomePageEvent{}

class BookHeadingTextClickedEvent extends HomePageEvent{}

class BookImageClickedEvent extends HomePageEvent{}
