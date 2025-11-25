import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class NavScreen extends StatefulWidget {
  static const routeName = '/nav';
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const Center(child: Text("Coming Soon", style: TextStyle(fontSize: 20))), // Placeholder
    const Center(child: Text("Downloads", style: TextStyle(fontSize: 20))), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'New & Hot'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Downloads'),
        ],
      ),
    );
  }
}