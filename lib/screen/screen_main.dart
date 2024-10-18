import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping/screen/home/screen_bookmark.dart';
import 'package:shopping/screen/home/screen_favorites.dart';
import 'package:shopping/screen/home/screen_home.dart';
import 'package:shopping/screen/home/screen_profile.dart';
import 'package:shopping/screen/home/screen_shopping.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    BookmarkPage(),
    ShoppingPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  final List<String> _svgPaths = const [
    "assets/svg/ic_nav_home",
    "assets/svg/ic_nav_bookmark",
    "assets/svg/ic_nav_shopping",
    "assets/svg/ic_nav_heart",
    "assets/svg/ic_nav_user",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildBottomNavItem(int index) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        '${_svgPaths[index]}${isSelected ? '_fill' : ''}.svg',
        width: 20 + (index == 2 || index == 3 ? 1 : 0),
        // Adjust width for specific icons
        height: 20 + (index == 2 || index == 3 ? 1 : 0),
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.blue : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          _svgPaths.length,
          (index) => _buildBottomNavItem(index),
        ),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
