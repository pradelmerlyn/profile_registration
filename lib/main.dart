import 'package:flutter/material.dart';

import 'core/custom_theme.dart';
import 'presentation/home/screens/home_screen.dart';

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
