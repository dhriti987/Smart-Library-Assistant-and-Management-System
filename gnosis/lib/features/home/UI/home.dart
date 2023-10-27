import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/favorites_page/UI/favorites_page.dart';
import 'package:gnosis/features/home/bloc/home_bloc.dart';
import 'package:gnosis/features/home_page/UI/home_page.dart';
import 'package:gnosis/features/library_page/UI/library_page.dart';
import 'package:gnosis/features/menu/UI/menu.dart';
import 'package:gnosis/features/notes_page/UI/notes_page.dart';
import 'package:gnosis/features/search/UI/mic_button.dart';
import 'package:gnosis/features/search/UI/search_text_field.dart';
import 'package:gnosis/service_locator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  late HomeBloc homeBloc;
  bool _isSearching = false;
  final pages = [
    HomePage(),
    LibraryPage(),
    null,
    FavoritesPage(),
    NotesPage(),
  ];
  final List<String> title = [
    "Home",
    "Library",
    "",
    "Favorites",
    "Notes"
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
      buildWhen: (previous, current) => current is! HomeActionState ,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PageChangeState) {
          pageIndex = state.pageIndex;
        }
        return Scaffold(
          drawer: MenuPage(),
          appBar: AppBar(
            title: getTitleWidget(pageIndex),
            backgroundColor: Color.fromARGB(255, 0, 40, 73),
            actions: [
              pageIndex==4?SizedBox():IconButton(
                  padding: EdgeInsets.only(right: 20),
                  onPressed: () => setState(() {
                    _isSearching = !_isSearching;
                  }),
                  icon: Icon(_isSearching?Icons.cancel:Icons.search)),
            ],
          ),
          body: pages[pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 0, 20, 39),
            currentIndex: pageIndex,
            fixedColor: Color.fromARGB(255, 0, 80, 146),
            onTap: (index) {
              _isSearching = false;
              homeBloc
                  .add(BottomNavigationBarIconClickedEvent(pageIndex: index));
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: 'Library'),
              BottomNavigationBarItem(icon: SizedBox() , label: ""),
                  
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_alt), label: 'Notes'),
            ],
          ),
          floatingActionButton: const MicButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // extendBodyBehindAppBar: true,
          // extendBody: true,
        );
      },
    );
  }
  Widget getTitleWidget(int index){
    if(_isSearching) return SearchTextField();
    return Text(title[index]);
  }
}
