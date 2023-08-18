import 'package:flutter/material.dart';
import 'package:weather_service/data/services/auth_service.dart';
import 'package:weather_service/presentation/utils/colors.dart';
import 'package:weather_service/presentation/utils/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // redirect to login or home page after 1 second
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        AuthService().currentUser == null
            ? AppRouter.loginRoute
            : AppRouter.homeRoute,
        (_) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: primaryDarkGradient,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 86),
        child: const Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'WEATHER SERVICE',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              'dawn is coming soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                fontFamily: 'Inter',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
