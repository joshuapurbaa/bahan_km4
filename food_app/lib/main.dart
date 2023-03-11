import 'package:flutter/material.dart';

void main() {
  // 1
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  // 2
  const FoodApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: Create theme
    // TODO: Apply Home widget
    // 3
    return MaterialApp(
      // TODO: Add theme
      title: 'Food App',
      // 4
      home: Scaffold(
        // TODO: Style the title
        appBar: AppBar(title: const Text('Food App')),
        // TODO: Style the body text
        body: const Center(child: Text('Let\'s get cooking 👩‍🍳')),
      ),
    );
  }
}
