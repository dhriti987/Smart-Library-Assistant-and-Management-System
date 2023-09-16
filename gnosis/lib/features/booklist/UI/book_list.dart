import 'package:flutter/material.dart';
import 'package:gnosis/features/booklist/UI/book_list_item.dart';
import 'package:gnosis/models/book_model.dart';

class BookList extends StatelessWidget {
  final String title;
  final Future<List<BookModel>> books;
  const BookList({super.key, required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: books,
        builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
            itemBuilder: (context, index) => BookListItem(
                  book: snapshot.data![index],
                  onTap: () {},
                ),
            itemCount: snapshot.data?.length ?? 0);
          }
          return Center(child: CircularProgressIndicator());
        },
    )
    );
  }
}
