import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/search/bloc/search_bloc.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({super.key});

  final SearchBloc searchBloc = sl.get<SearchBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      bloc: searchBloc,
      listenWhen: (previous, current) => current is SearchActionState,
      listener: (context, state) {
        if(state is DisplayBookListResult){
          context.pushNamed('BookList',extra: state.books, pathParameters: {'title': state.title});
        }
      },
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'search book by name',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding: const EdgeInsets.all(8),
        ),
        onSubmitted: (value) {
          print(value);
          searchBloc.add(SearchTextFieldSubmitEvent(searchQuery: value));
        },
      ),
    );
  }
}
