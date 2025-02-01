import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/book_description/bloc/book_description_bloc.dart';
import 'package:gnosis/features/home_page/repository/home_repo.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class BookDescriptionPage extends StatefulWidget {
  const BookDescriptionPage({
    super.key,
    required this.book,
  });
  final BookModel book;

  @override
  State<BookDescriptionPage> createState() => _BookDescriptionPageState();
}

class _BookDescriptionPageState extends State<BookDescriptionPage> {
  late HomeRepository homeRepository;
  late BookDescriptionBloc bookDescriptionBloc;

  _BookDescriptionPageState();

  @override
  void initState() {
    homeRepository = sl.get<HomeRepository>();
    bookDescriptionBloc = sl.get<BookDescriptionBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
            SizedBox(
              width: double.maxFinite,
              height: size.height / 4,
              child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: FutureBuilder(
                        future: homeRepository.getImage(widget.book.imgUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              child: ImageFiltered(
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Image.memory(
                                  snapshot.data ?? Uint8List(0),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: Icon(Icons.image),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: size.height / 8,
                      child: SizedBox(
                        width: size.width / 3,
                        height: size.height / 4,
                        child: FutureBuilder(
                          future: homeRepository.getImage(widget.book.imgUrl),
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
                            return const Center(
                              child: Icon(Icons.image),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height / 16 - 10, horizontal: size.width / 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Year', style: textTheme.titleLarge),
                      Text(
                        widget.book.year,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Ratings', style: textTheme.titleLarge),
                      Text(
                        widget.book.ratings.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                widget.book.title,
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
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
                            Text(widget.book.author.join('\n')),
                            // TextButton(
                            //   onPressed: () {},
                            //   child: Text(
                            //     'More Info...',
                            //     style: TextStyle(fontSize: 16),
                            //   ),
                            // )
                          ],
                        ),
                        const VerticalDivider(
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
                            Text(widget.book.publisher),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Category', style: textTheme.titleLarge),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: widget.book.category.map((e) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            margin: const EdgeInsets.only(left: 10, bottom: 10),
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
                  const Divider(
                    color: Colors.white24,
                  ),
                  Column(
                    children: [
                      Text('Synopsis', style: textTheme.titleLarge),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(widget.book.description),
                      )
                    ],
                  ),
                ],
              ),
            ),
            widget.book.bookFile != null
                ? BlocListener<BookDescriptionBloc, BookDescriptionState>(
                  bloc: bookDescriptionBloc,
                  listenWhen: (previous, current) => current is BookDescriptionActionState,
                    listener: (context, state) {
                      if(state is NavigateToBookReadPage){
                        context.push("/book_reader", extra: state.book);
                      }
                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          bookDescriptionBloc.add(ReadBookButtonClickedEvent(book: widget.book));
                        },
                        child: const Text('Read Book'),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
