import 'package:flutter/material.dart';
import 'package:food_app/styles/themes.dart';

import 'screens/home.dart';

void main() {
  // 1
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // 2
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create theme
    final theme = AppTheme.dark();
    return MaterialApp(
      title: 'Food App',
      theme: theme,
      home: const Home(),
    );
  }
}
