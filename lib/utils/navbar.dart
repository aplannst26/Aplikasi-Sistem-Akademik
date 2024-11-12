import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0; // New

  // New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navbar'),
      ),
      body: Center(
        child: Text(
          'Index yang dipilih: $_selectedIndex',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColor.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard,
              color: AppColor.primary,
            ),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.percent_outlined,
              color: AppColor.primary,
            ),
            label: 'Discounts',
          ),
        ],
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped,         
      ),
    );
  }
}