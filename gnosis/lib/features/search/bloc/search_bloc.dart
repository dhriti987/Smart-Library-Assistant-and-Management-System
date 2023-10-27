import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/features/search/repository/search_repository.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository = sl.get<SearchRepository>();
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SearchTextFieldSubmitEvent>(searchTextFieldSubmitEvent);
    on<SearchMicButtonOnClickedEvent>(searchMicButtonOnClickedEvent);
    on<SearchMicStateChangeEvent>(searchMicStateChangeEvent);
    on<MicInputQueryResolveSearchEvent>(micInputQueryResolveSearchEvent);
  }

  FutureOr<void> searchTextFieldSubmitEvent(SearchTextFieldSubmitEvent event, Emitter<SearchState> emit) async{
    final data = searchRepository.search(event.searchQuery);
    emit(DisplayBookListResult(title: "Your Search Result", books: data));
  }


  FutureOr<void> searchMicButtonOnClickedEvent(SearchMicButtonOnClickedEvent event, Emitter<SearchState> emit) {
    emit(MicButtonClickedState());
  }

  FutureOr<void> searchMicStateChangeEvent(SearchMicStateChangeEvent event, Emitter<SearchState> emit) {
    emit(MicStateChange());
  }

  FutureOr<void> micInputQueryResolveSearchEvent(MicInputQueryResolveSearchEvent event, Emitter<SearchState> emit) async{
    print("calling api");
    var result = await searchRepository.resolveQuery(event.searchQuery);

      print(result);
    if(result['result'] is List){
      final booklist = BookModel.listFromJson(result['result'] as List);
      if(booklist.isNotEmpty){
        print("list");
        emit(DisplayBookListResultWithReply(title: "Your Books", books: Future.value(booklist), reply: result['reply']));
        return;
      }
    }
    else if(result['result'] is Map){
      print("book");
      final book = BookModel.fromJson(result['result']);
      emit(DisplayBookResultWithReply(title: "", books: book, reply: result['reply']));
      return;
    }
    emit(NoBookFoundStateWithReply(reply: result['reply']));
  }
}
