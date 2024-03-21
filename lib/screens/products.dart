import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final Function(int) onNavigate;

  const Products({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => onNavigate(2), // Navigate to 'About' page index
          child: const Text('Go to Location'),
        ),
      ),
    );
  }
}
