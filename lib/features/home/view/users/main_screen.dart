import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/home/view/users/screen/cart_screen.dart';
import 'package:e_commerce_app/features/home/view/users/screen/home_screen.dart';
import 'package:e_commerce_app/features/home/view/users/screen/profile_screen.dart';
import 'package:e_commerce_app/features/home/view/users/screen/saved_screen.dart';
import 'package:e_commerce_app/features/home/view/users/screen/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages; // Declare _pages as late

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(),
      ProductSearchScreen(),
      SavedScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primary0,
          selectedItemColor: AppColors.primary900,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 24,
                color: _currentIndex == 0
                    ? AppColors.primary900
                    : AppColors.primary400,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/search.png',
                width: 24,
                color: _currentIndex == 1
                    ? AppColors.primary900
                    : AppColors.primary400,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/save.png',
                width: 24,
                color: _currentIndex == 2
                    ? AppColors.primary900
                    : AppColors.primary400,
              ),
              label: 'Save',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/cart.png',
                width: 24,
                color: _currentIndex == 3
                    ? AppColors.primary900
                    : AppColors.primary400,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/user.png',
                width: 24,
                color: _currentIndex == 4
                    ? AppColors.primary900
                    : AppColors.primary400,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}