import 'package:flutter/material.dart';
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
      routerConfig: sl.get<AppRouter>().getRouter(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
    );
  }
}
