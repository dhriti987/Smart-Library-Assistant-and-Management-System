part of 'category_list_bloc.dart';

@immutable
sealed class CategoryListEvent {}

class CategoryListFetchEvent extends CategoryListEvent {}

class CategoryClickedEvent extends CategoryListEvent {
  final String category;

  CategoryClickedEvent({required this.category});
}