import 'package:flutter/material.dart';
import 'package:weather_service/presentation/pages/home_page.dart';

class AppRouter {
  static const String homeRoute = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
