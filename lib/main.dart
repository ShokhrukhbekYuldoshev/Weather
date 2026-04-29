import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_service/cubit/home/home_cubit.dart';
import 'package:weather_service/data/services/hive_adapters.dart';
import 'package:weather_service/presentation/pages/home_page.dart';
import 'package:weather_service/presentation/utils/colors.dart';
import 'package:weather_service/presentation/utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  registerHiveAdapters();
  await Hive.openBox('myBox');

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeCubit())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const HomePage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
