import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/authorlist/UI/author_list_item.dart';
import 'package:gnosis/features/authorlist/bloc/author_list_bloc.dart';
import 'package:gnosis/models/author_model.dart';

class AuthorList extends StatefulWidget {
  const AuthorList({super.key});

  @override
  State<AuthorList> createState() => _AuthorListState();
}

class _AuthorListState extends State<AuthorList> {
  AuthorListBloc authorListBloc = AuthorListBloc();
  List<AuthorModel> authors = [
    AuthorModel(
      name: "J. K. Rowling",
      bio: 'bio',
      dob: 'dob',
      wikiLink: 'wikiLink',
      imgURL:
          'https://m.media-amazon.com/images/S/amzn-author-media-prod/8cigckin175jtpsk3gs361r4ss.jpg',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authors')),
      body: BlocConsumer<AuthorListBloc, AuthorListState>(
        bloc: authorListBloc,
        listenWhen: (previous, current) => current is AuthorListActionState,
        buildWhen: (previous, current) => current is! AuthorListActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthorListInitial) {
            authorListBloc.add(AuthorListFetchEvent());
          }
          if (state is AuthorListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthorListSuccessState) {
            authors = state.authorList;
          }
          return GridView.builder(
            itemCount: authors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 2/3,),
            itemBuilder: (context, index) {
              return AuthorListItem(
                author: authors[index],
              );
            },
          );
        },
      ),
    );
  }
}
