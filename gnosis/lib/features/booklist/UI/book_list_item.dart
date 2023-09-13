import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/features/home/repository/home_repo.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';

class BookListItem extends StatelessWidget {
  final BookModel book;
  final Function onTap;
  final HomeRepository homeRepo =
      HomeRepository(apiService: sl.get<ApiService>());
  BookListItem({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 180,
        margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.indigo.shade700, Colors.indigo.shade900]),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: FutureBuilder(
                future: homeRepo.getImage(book.imgUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          snapshot.data ?? Uint8List(0),
                          width: 120,
                          fit: BoxFit.fill,
                        ));
                  }
                  return const Icon(Icons.image);
                },
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: textTheme.labelMedium
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Category: \n${book.category.join(", ")}",
                      style: textTheme.labelMedium
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    Text("Authored By: \n${book.author.join(" & ")}",
                      style: textTheme.labelMedium
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
