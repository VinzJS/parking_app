import 'package:flutter/material.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Bookings'),
      ),
      body: const Center(
        child: Text('Booking Screen'),
      ),
    );
  }
}
