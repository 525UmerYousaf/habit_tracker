// initialRoute: '/',
//       routes: {
//         '/': (context) => const LoginScreen(),
//         '/register_screen': (context) => const RegisterScreen(),
//       },

import 'package:flutter/material.dart';
import 'package:habitt_app/screens/login_screen.dart';
import 'package:habitt_app/screens/register_screen.dart';

class RouteNames {
  static const String registerScreen = "/registerScreen";
  static const String loginScreen = "/loginScreen";
}

typedef WidgetBuilder = Widget Function(BuildContext);

class AppRouter {
  Map<String, WidgetBuilder> get appRoutes {
    return {
      RouteNames.registerScreen: (context) => const RegisterScreen(),
      RouteNames.loginScreen: (context) => const LoginScreen(),
    };
  }
}
