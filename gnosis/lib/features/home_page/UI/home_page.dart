import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/home_page/bloc/home_page_bloc.dart';
import 'package:gnosis/features/home_page/repository/home_repo.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topList = ['Genres', 'Top Reted', 'New Launched'];
  // final bookList = {
  //   "Twilight":
  //       "https://upload.wikimedia.org/wikipedia/en/1/1d/Twilightbook.jpg",
  //   "New Moon":
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3rth1CWmpkN0g-lVufd4QY_hRS6xdiHyFzw&usqp=CAU",
  //   "Eclipse":
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe3TSolpYt9IkUJ_4khLVzgQTAjqxpLBCjww&usqp=CAU",
  //   "Breacking Dawn":
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNyIfU76bSSz1VFrXE26ZsC5lUvenduUGC6A&usqp=CAU",
  //   "Midnight Sun":
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy8XZf4jxPUTA3wlFKIpG2DsQK1EOb6ykofg&usqp=CAU",
  // };
  late HomePageBloc homePageBloc;
  late HomeRepository homeRepository;
  List<BookModel> recommendedBooks = [];
  List<BookModel> topRatedBooks = [];
  final image =
      'https://upload.wikimedia.org/wikipedia/en/1/1d/Twilightbook.jpg';

  @override
  void initState() {
    // TODO: implement initState
    homePageBloc = sl.get<HomePageBloc>();
    homeRepository = sl.get<HomeRepository>();
    homePageBloc.add(HomePageInitailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocConsumer<HomePageBloc, HomePageState>(
      bloc: homePageBloc,
      listenWhen: (previous, current) => current is HomePageActionState,
      buildWhen: (previous, current) => current is! HomePageActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomePageToBookDescriptionPageActionState) {
          context.push('/book_description',extra: state.book);
        }
      },
      builder: (context, state) {
        if (state is HomePageLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is HomePageSuccessState) {
          recommendedBooks = state.recommendedBooks;
          topRatedBooks = state.topRatedBooks;
        }
        return Container(
          height: double.maxFinite,
          width: double.maxFinite,
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
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                padding: EdgeInsets.only(left: 20),
                width: double.maxFinite,
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: topList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ElevatedButton(
                        onPressed: () {}, child: Text(topList[index]));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 20),
                color: Colors.white10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Recommended for you',
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Based on your reading',
                        style: textTheme.labelMedium,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: double.maxFinite,
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedBooks.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            width: 130,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FutureBuilder(
                              future: homeRepository
                                  .getImage(recommendedBooks[index].imgUrl),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return InkWell(
                                    onTap: () {
                                      homePageBloc.add(BookImageClickedEvent(book: recommendedBooks[index]));
                                    },
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 120,
                            child: Center(
                              child: Text(
                                recommendedBooks[index].title,
                                textWidthBasis: TextWidthBasis.parent,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                color: Colors.white10,
                width: double.maxFinite,
                child: Text(
                  'Top Rated',
                  style: textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: double.maxFinite,
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: topRatedBooks.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            width: 130,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FutureBuilder(
                              future: homeRepository
                                  .getImage(topRatedBooks[index].imgUrl),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return InkWell(
                                    onTap: () {
                                      homePageBloc.add(BookImageClickedEvent(book: topRatedBooks[index]));
                                    },
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 120,
                            child: Center(
                              child: Text(
                                topRatedBooks[index].title,
                                textWidthBasis: TextWidthBasis.parent,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
