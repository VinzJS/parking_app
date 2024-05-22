import 'package:flutter/material.dart';
import 'parking_spots_screen.dart';
 // Import the screen that shows the parking spots

class ParkScreen extends StatelessWidget {
  ParkScreen({super.key});

  final List<String> locations = [
    'USLS Parking Lot',
    'La Salle Shaded Free Parking Area',
    'Unified Parking Lot for Food-Joints',
    'SM Southwing Motor Parking Area',
    'Circle Inn Parking Lot'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Park'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(locations[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ParkingSpotsScreen(location: locations[index])),
              );
            },
          );
        },
      ),
    );
  }
}
