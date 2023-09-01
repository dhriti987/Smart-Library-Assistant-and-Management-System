import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gnosis/core/theme/common_theme.dart';
import 'package:gnosis/service_locator.dart';
import 'core/router/router.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routeInformationParser: AppRouter().router.routeInformationParser,
      // routerDelegate: AppRouter().router.routerDelegate,
      routerConfig: GetIt.instance.get<AppRouter>().getRouter(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
    );
  }
}
