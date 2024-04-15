import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../utils/const/icons_image.dart';
import 'bank/transaction.dart';
import 'home/home_screen.dart';
import 'reserve/mybooking_screen.dart';
import 'profile/userprofle_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Transaction(),
    const MyBooking(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black12,
            )
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
                  label: '',
                ),
                _buildGButton(
                  index: 1,
                  selectedIcon: AppIcons.bank,
                  nonSelectedIcon: AppIcons.bankOutlined,
                  label: '',
                ),
                _buildGButton(
                  index: 2,
                  selectedIcon: AppIcons.newspaper,
                  nonSelectedIcon: AppIcons.newspaperOutlined,
                  label: '',
                ),
                _buildGButton(
                  index: 3,
                  selectedIcon: AppIcons.user,
                  nonSelectedIcon: AppIcons.userOutlined,
                  label: '',
                ),
              ],
              gap: 4,
              color: Colors.grey[800]!,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 800),
              tabBackgroundColor: Colors.grey[100]!,
              // tabBorderRadius: 20,
            ),
          ),
        ),
      ),
    );
  }

  GButton _buildGButton({
    required String selectedIcon,
    required String nonSelectedIcon,
    required String label,
    required int index,
  }) {
    bool isSelected = index == _selectedIndex;
    return GButton(
      icon: Icons.abc,
      leading: SvgPicture.asset(
        isSelected ? selectedIcon : nonSelectedIcon,
        width: 24,
        height: 24,
        // ignore: deprecated_member_use
        color: Colors.black,
      ),
      text: label,
      textColor: Colors.black,
      backgroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      rippleColor: Colors.transparent,
      // border: isSelected
      //     ? Border.all(color: Colors.black, width: 2)
      //     : Border.all(color: Colors.transparent),
      onPressed: isSelected ? null : () => _onItemTapped(index),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
