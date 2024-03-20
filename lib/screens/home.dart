import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function(int) onNavigate;

  const Home({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => onNavigate(2), // Navigate to 'About' page index
          child: const Text('Go to About'),
        ),
      ),
    );
  }
}
