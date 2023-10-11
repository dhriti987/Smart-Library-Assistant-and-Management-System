import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gnosis/features/home_page/repository/home_repo.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';

class BookDescriptionPage extends StatefulWidget {
  BookDescriptionPage({
    super.key,
    required this.book,
  });
  final BookModel book;

  @override
  State<BookDescriptionPage> createState() =>
      _BookDescriptionPageState(book: book);
}

class _BookDescriptionPageState extends State<BookDescriptionPage> {
  late HomeRepository homeRepository;
  final BookModel book;

  _BookDescriptionPageState({required this.book});

  @override
  void initState() {
    // TODO: implement initState
    homeRepository = sl.get<HomeRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 210,
                      child: FutureBuilder(
                        future: homeRepository.getImage(book.imgUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              child: ImageFiltered(
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Image.memory(
                                  snapshot.data ?? Uint8List(0),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Icon(Icons.image),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 130,
                    right: 130,
                    child: SizedBox(
                      width: 130,
                      height: 200,
                      child: FutureBuilder(
                        future: homeRepository.getImage(book.imgUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                snapshot.data ?? Uint8List(0),
                                fit: BoxFit.fill,
                              ),
                            );
                          }
                          return Center(
                            child: Icon(Icons.image),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230,
                    left: 35,
                    child: Container(
                      child: Column(
                        children: [
                          Text('Year', style: textTheme.titleLarge),
                          Text(
                            book.year,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230,
                    right: 35,
                    child: Container(
                      child: Column(
                        children: [
                          Text('Ratings', style: textTheme.titleLarge),
                          Text(
                            book.ratings.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 290,
                    left: 20,
                    right: 20,
                    child: Text(
                      book.title,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Authored by ',
                              style: textTheme.titleLarge,
                            ),
                            Text(book.author.join('\n')),
                            // TextButton(
                            //   onPressed: () {},
                            //   child: Text(
                            //     'More Info...',
                            //     style: TextStyle(fontSize: 16),
                            //   ),
                            // )
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.white24,
                          thickness: 1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Published by',
                              style: textTheme.titleLarge,
                            ),
                            Text(book.publisher),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Category', style: textTheme.titleLarge),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: book.category.map((e) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(e),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.white24,
                  ),
                  Column(
                    children: [
                      Text('About the Book', style: textTheme.titleLarge),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(book.description),
                      )
                    ],
                  ),
                ],
              ),
            ),
            book.bookFile != null
                ? Container(
                    height: 70,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Read Book'),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
