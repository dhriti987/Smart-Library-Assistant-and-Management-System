// import 'package:flutter/material.dart';
import 'package:gnosis/features/Sigin/UI/Sign_in.dart';
import 'package:gnosis/features/book_description/UI/book_description.dart';
import 'package:gnosis/features/forgot_password/UI/forgot_password.dart';
import 'package:gnosis/features/home/UI/home.dart';
import 'package:gnosis/features/menu/UI/menu.dart';
import 'package:gnosis/models/book_model.dart';
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
            return BookDescriptionPage(book: book,);
          },
        )
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
