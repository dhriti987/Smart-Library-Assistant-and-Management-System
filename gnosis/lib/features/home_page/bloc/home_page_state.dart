part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

abstract class HomePageActionState extends HomePageState{}

final class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState{}

class HomePageSuccessState extends HomePageState{}

class HomePageToBookDescriptionPageActionState extends HomePageActionState{}
