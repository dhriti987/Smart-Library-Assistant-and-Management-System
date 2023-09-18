import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/booklist/UI/book_list_item.dart';
import 'package:gnosis/features/booklist/bloc/book_list_bloc.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class BookList extends StatefulWidget {
  final String title;
  final Future<List<BookModel>> books;
  const BookList({super.key, required this.title, required this.books});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late BookListBloc bookListBloc;

  @override
  void initState() {
    // TODO: implement initState
    bookListBloc = sl.get<BookListBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookListBloc, BookListState>(
      bloc: bookListBloc,
      listenWhen: (previous, current) => current is BookListActionState,
      buildWhen: (previous, current) => current is! BookListActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is BookListPageToBookDescriptionPageActionState) {
          context.push('/book_description', extra: state.book);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 0, 40, 73),
                  Color.fromARGB(255, 0, 20, 39),
                ],
              ),
            ),
            child: FutureBuilder(
              future: widget.books,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemBuilder: (context, index) => BookListItem(
                      book: snapshot.data![index],
                      onTap: () {
                        bookListBloc.add(
                          BookListElementClickedEvent(book: snapshot.data![index]),
                        );
                      },
                    ),
                    itemCount: snapshot.data?.length ?? 0,
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          extendBodyBehindAppBar: true,
        );
      },
    );
  }
}
