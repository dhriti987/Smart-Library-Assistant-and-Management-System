import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/home/bloc/home_bloc.dart';
import 'package:gnosis/features/home_page/UI/home_page.dart';
import 'package:gnosis/features/library_page/UI/library_page.dart';
import 'package:gnosis/features/notes_page/UI/notes_page.dart';
import 'package:gnosis/service_locator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  late HomeBloc homeBloc;
  final pages = [
    HomePage(),
    LibraryPage(),
    NotesPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    homeBloc = sl.get<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PageChangeState) {
          pageIndex = state.pageIndex;
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                padding: EdgeInsets.only(left: 20),
                onPressed: () {},
                icon: Icon(Icons.menu)),
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  onPressed: () {},
                  icon: Icon(Icons.search)),
            ],
          ),
          body: pages[pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (index) {
              homeBloc.add(
                  BottomNavigationBarIconClickedEvent(pageIndex: index));
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: 'Library'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_alt), label: 'Notes'),
            ],
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
        );
      },
    );
  }
}
