part of 'menu_bloc.dart';

@immutable
sealed class MenuState {}
sealed class MenuActionState extends MenuState{}

final class MenuInitial extends MenuState {}

final class GoToSignInPageMenuActionState extends MenuActionState {}