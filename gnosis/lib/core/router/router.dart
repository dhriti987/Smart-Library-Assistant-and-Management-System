// import 'package:flutter/material.dart';
import 'package:gnosis/features/Sigin/UI/Sign_in.dart';
import 'package:gnosis/features/author_info/UI/author_info.dart';
import 'package:gnosis/features/book_description/UI/book_description.dart';
import 'package:gnosis/features/book_reader/UI/book_reader.dart';
import 'package:gnosis/features/booklist/UI/book_list.dart';
import 'package:gnosis/features/categorylist/UI/category_list.dart';
import 'package:gnosis/features/forgot_password/UI/forgot_password.dart';
import 'package:gnosis/features/home/UI/home.dart';
import 'package:gnosis/features/menu/UI/menu.dart';
import 'package:gnosis/features/notes_editor/UI/notes_editor.dart';
import 'package:gnosis/features/notes_reader/UI/notes_reader.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:gnosis/models/notes_model.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  final SharedPreferences pref;

  AppRouter({required this.pref});

  bool checkIsAuthenticated() {
    return pref.getString('token') != null;
  }

  GoRouter getRouter() {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/signin',
          name: 'Sign_in',
          builder: (context, state) {
            return SignIn();
          },
        ),
        GoRoute(
          path: '/',
          name: 'Home',
          builder: (context, state) {
            return Home();
          },
        ),
        GoRoute(
          path: '/forgot_password',
          name: 'ForgotPassword',
          builder: (context, state) {
            return ForgotPassword();
          },
        ),
        GoRoute(
          path: '/menu',
          name: 'MenuPage',
          builder: (context, state) {
            return MenuPage();
          },
        ),
        GoRoute(
          path: '/book_description',
          name: 'BookDescriptionPage',
          builder: (context, state) {
            BookModel book = state.extra as BookModel;
            return BookDescriptionPage(
              book: book,
            );
          },
        ),
        GoRoute(
          path: '/book_list/:title',
          name: 'BookList',
          builder: (context, state) {
            var books = state.extra as Future<List<BookModel>>;
            var title = state.pathParameters["title"] ?? "";
            return BookList(title: title, books: books);
          },
        ),
        GoRoute(
          path: '/category_list',
          name: 'CategoryList',
          builder: (context, state) {
            return CategoryList();
          },
        ),
        GoRoute(
          path: '/author_info',
          name: 'AuthorInfo',
          builder: (context, state) {
            return AuthorInfo();
          },
        ),
        GoRoute(
          path: '/note_editor',
          name: 'NotesEditor',
          builder: (context, state) {
            NotesModel data = state.extra as NotesModel;
            return NotesEditor(note: data);
          },
        ),
        GoRoute(
          path: '/note_reader',
          name: 'NotesReader',
          builder: (context, state) {
            NotesModel data = state.extra as NotesModel;
            return NotesReader(note: data);
          },
        ),
        GoRoute(
          path: '/book_reader',
          name: 'BookReader',
          builder: (context, state) {
            BookModel data = state.extra as BookModel;
            return BookReader(book: data);
          },
        ),
      ],
      redirect: (context, state) {
        if (checkIsAuthenticated()) {
          return null;
        }
        return '/signin';
      },
    );
    return router;
  }
}
