import 'package:flutter/material.dart';
import 'package:gnosis/core/theme/common_theme.dart';
import 'core/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routeInformationParser: AppRouter().router.routeInformationParser,
      // routerDelegate: AppRouter().router.routerDelegate,
      routerConfig: AppRouter().getRouter(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
    );
  }
}
