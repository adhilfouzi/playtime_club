import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../utils/const/icons_image.dart';
import '../revenue/revenue_screen.dart';
import '../home/home_screen.dart';
import '../reserve/mybooking_screen.dart';
import '../profile/userprofle_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    Revenue(),
    Reservation(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds the bottom navigation bar using GNav.
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black12,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            tabs: [
              _buildGButton(
                index: 0,
                selectedIcon: AppIcons.home,
                nonSelectedIcon: AppIcons.homeOutlined,
                label: 'Home',
              ),
              _buildGButton(
                index: 1,
                selectedIcon: AppIcons.bank,
                nonSelectedIcon: AppIcons.bankOutlined,
                label: 'Revenue',
              ),
              _buildGButton(
                index: 2,
                selectedIcon: AppIcons.newspaper,
                nonSelectedIcon: AppIcons.newspaperOutlined,
                label: 'Booking',
              ),
              _buildGButton(
                index: 3,
                selectedIcon: AppIcons.user,
                nonSelectedIcon: AppIcons.userOutlined,
                label: 'Profile',
              ),
            ],
            gap: 4,
            color: Colors.grey[800]!,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 800),
            tabBackgroundColor: Colors.grey[100]!,
          ),
        ),
      ),
    );
  }

  /// Builds a GButton for the navigation bar.
  GButton _buildGButton({
    required String selectedIcon,
    required String nonSelectedIcon,
    required String label,
    required int index,
  }) {
    bool isSelected = index == _selectedIndex;
    return GButton(
      icon: Icons.abc, // Placeholder, actual icon is set using SvgPicture
      leading: SvgPicture.asset(
        isSelected ? selectedIcon : nonSelectedIcon,
        width: 24,
        height: 24,
        color: Colors.black,
      ),
      text: label,
      textColor: Colors.black,
      backgroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      rippleColor: Colors.transparent,
      onPressed: isSelected ? null : () => _onItemTapped(index),
    );
  }

  /// Handles tab changes in the navigation bar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
