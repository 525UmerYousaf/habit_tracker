import 'package:flutter/material.dart';

import './screens/login_screen.dart';
import './utils/app_router.dart';

void main() {
  runApp(const HabittApp());
}

class HabittApp extends StatelessWidget {
  const HabittApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitt App',
      routes: AppRouter().appRoutes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
