// import 'package:flutter/material.dart';
import 'package:gnosis/features/Sigin/UI/Sign_in.dart';
import 'package:gnosis/features/home/UI/home.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter getRouter(bool isSignIn) {
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
        if (isSignIn) {
          return null;
        }
        return '/signin';
      },
    );
    return router;
  }
}
