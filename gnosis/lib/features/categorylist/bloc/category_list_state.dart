part of 'category_list_bloc.dart';

@immutable
sealed class CategoryListState {}

@immutable
sealed class CategoryListActionState extends CategoryListState {}

final class CategoryListInitial extends CategoryListState {}

final class CategoryListLoadingState extends CategoryListState {}

class CategoryListSuccessState extends CategoryListState {
  final List<String> categoryList;

  CategoryListSuccessState({required this.categoryList});
}

class CategoryListErrorState extends CategoryListState {}

class DisplayCategoryBooksState extends CategoryListActionState {
  final String title;
  final Future<List<BookModel>> books;

  DisplayCategoryBooksState({required this.books,required this.title});
}
