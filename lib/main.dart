import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/products.dart';
import './screens/about.dart';
import './widgets/custom_app_bar.dart';
import './widgets/custom_bottom_navigation_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BaseWidget(),
    );
  }
}

Widget _buildAppBar(int selectedIndex) {
  String title;
  switch (selectedIndex) {
    case 0:
      title = 'Home';
      break;
    case 1:
      title = 'Products';
      break;
    case 2:
      title = 'About';
      break;
    default:
      title = 'App';
  }

  // Return an instance of CustomAppBar
  return CustomAppBar(title: title);
}

class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(_selectedIndex) as PreferredSizeWidget,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Home(onNavigate: _onItemTapped),
          const Products(),
          const About(),
        ], // Prevents swiping to side pages
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}