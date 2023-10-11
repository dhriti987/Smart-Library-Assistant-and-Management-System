import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/features/categorylist/repository/category_list_repo.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final CategoryListRepository categoryListRepository =
      sl.get<CategoryListRepository>();
  CategoryListBloc() : super(CategoryListInitial()) {
    on<CategoryListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CategoryListFetchEvent>(categoryListFetchEvent);
    on<CategoryClickedEvent>(categoryClickedEvent);
  }

  FutureOr<void> categoryListFetchEvent(
      CategoryListFetchEvent event, Emitter<CategoryListState> emit) async {
    emit(CategoryListLoadingState());
    List<String> categories = await categoryListRepository.getCategories();
    emit(CategoryListSuccessState(categoryList: categories));
  }

  FutureOr<void> categoryClickedEvent(
      CategoryClickedEvent event, Emitter<CategoryListState> emit) {
    var books =
        categoryListRepository.getBooksByCategory(event.category);
    emit(DisplayCategoryBooksState(books: books, title: event.category));
  }
}
