import 'package:flutter/material.dart';
import 'package:parking_app/screens/home_screen.dart';
import 'package:parking_app/screens/park_screen.dart';
import 'package:parking_app/screens/bookings_screen.dart';
import 'package:parking_app/screens/history_screen.dart';


class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ParkScreen(),
    const BookingsScreen(),
    const HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Added to ensure the background color works
        backgroundColor: Colors
            .amber[800], // This should now work with the type set to fixed
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_parking), label: 'Park'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
