import 'package:flutter/material.dart';
import 'package:weather_service/presentation/pages/home_page.dart';
import 'package:weather_service/presentation/pages/login_page.dart';
import 'package:weather_service/presentation/pages/register_page.dart';
import 'package:weather_service/presentation/pages/splash_page.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
    }
  }
}
