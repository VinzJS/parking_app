import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:parking_app/screens/home_screen.dart';
import 'register_screen.dart';
import 'base_widget.dart'; // Import your BaseWidget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/base': (context) => const BaseWidget(), // Add this route
      },
    );
  }
}
