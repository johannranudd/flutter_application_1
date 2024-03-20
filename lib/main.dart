import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/products.dart';
import './screens/about.dart';
import './widgets/custom_bottom_navigation_bar.dart'; // Adjust import paths as necessary

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const Home(), const Products(), const About()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => _pages[0], // Home
        '/products': (context) => _pages[1], // Products
        '/about': (context) => _pages[2], // About
      },
      home: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onItemSelected: _onItemTapped,
        ),
      ),
    );
  }
}
