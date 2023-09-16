import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/features/home_page/repository/home_repo.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomeRepository homeRepository = sl.get<HomeRepository>();
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomePageInitailEvent>(homePageInitialEvent);
    on<BookImageClickedEvent>(bookImageClickedEvent);
  }

  FutureOr<void> homePageInitialEvent(
      HomePageInitailEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    try {
      var recommendedBooks = await homeRepository.getRecommendedBooks();
      var topRatedBooks = await homeRepository.getTopRatedBooks();
      emit(HomePageSuccessState(
          recommendedBooks: recommendedBooks, topRatedBooks: topRatedBooks));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> bookImageClickedEvent(
      BookImageClickedEvent event, Emitter<HomePageState> emit) {
    emit(HomePageToBookDescriptionPageActionState(book: event.book));
  }
}
