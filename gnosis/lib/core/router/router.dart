// import 'package:flutter/material.dart';
import 'package:gnosis/features/Sigin/UI/Sign_in.dart';
import 'package:gnosis/features/home/UI/home.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  final SharedPreferences pref;

  AppRouter({required this.pref});

  bool checkIsAuthenticated(){
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
