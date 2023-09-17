import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:meta/meta.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListInitial()) {
    on<CategoryListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CategoryListFetchEvent>(categoryListFetchEvent);
  }

  FutureOr<void> categoryListFetchEvent(CategoryListFetchEvent event, Emitter<CategoryListState> emit) {
  }
}
