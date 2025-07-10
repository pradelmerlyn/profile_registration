import 'package:flutter/material.dart';
import 'package:sprint1_activity/core/custom_theme.dart';
import 'package:sprint1_activity/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomAppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
