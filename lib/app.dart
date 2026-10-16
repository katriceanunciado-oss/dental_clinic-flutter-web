import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'routes/app_routes.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
class SemesterProjectApp extends StatelessWidget {
  const SemesterProjectApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: AppConstants.title,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (_) => const HomeScreen(),
      AppRoutes.login: (_) => const LoginScreen(),
    },
  );
}
