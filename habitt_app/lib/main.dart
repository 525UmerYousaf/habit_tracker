import 'package:flutter/material.dart';
import 'package:habitt_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './utils/app_router.dart';
import 'screens/habit_tracker_screen.dart';
import 'utils/app_constants.dart';
import 'utils/error_screen.dart';
import 'utils/waiting_screen.dart';

void main() {
  runApp(const HabittApp());
}

class HabittApp extends StatefulWidget {
  const HabittApp({super.key});

  @override
  State<HabittApp> createState() => _HabittAppState();
}

class _HabittAppState extends State<HabittApp> {
  @override
  void initState() {
    localUser = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitt App',
      routes: AppRouter().appRoutes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: localUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen();
          } else if ((snapshot.connectionState != ConnectionState.waiting) &&
              snapshot.hasError) {
            return const ErrorScreen();
          } else if ((snapshot.connectionState == ConnectionState.done) &&
              snapshot.hasData) {
            SharedPreferences? localStorageObj = snapshot.data;
            if (localStorageObj != null) {
              bool? userLoginStatus =
                  localStorageObj.getBool(AppConstants.userLoginStatusVal);
              String? storedUserName =
                  localStorageObj.getString(AppConstants.userNameVal);
              String? storedEmailVal =
                  localStorageObj.getString(AppConstants.userNameVal);
              if (userLoginStatus != null &&
                  userLoginStatus == true &&
                  (storedUserName != null || storedEmailVal != null)) {
                return HabitTrackerScreen(
                  username: storedUserName ?? storedEmailVal ?? '',
                );
              } else {
                return const LoginScreen();
              }
            } else {
              return const ErrorScreen();
            }
          } else {
            return const WaitingScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
