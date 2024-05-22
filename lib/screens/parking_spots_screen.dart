import 'package:flutter/material.dart';
import 'reserve_parking_spot.dart';

class ParkingSpotsScreen extends StatefulWidget {
  const ParkingSpotsScreen({Key? key, required this.location})
      : super(key: key);

  final String location;

  @override
  _ParkingSpotsScreenState createState() => _ParkingSpotsScreenState();
}

class _ParkingSpotsScreenState extends State<ParkingSpotsScreen> {
  Set<String> reservedSpots = Set();

  final Map<String, Map<String, dynamic>> reservations = {};

  final List<String> parkingSpots = [
    'assets/spot1.jpg',
    'assets/spot2.jpg',
    'assets/spot3.jpg',
    'assets/spot4.jpg',
    'assets/spot5.jpg',
    'assets/spot6.jpg',
    'assets/spot7.jpg',
    'assets/spot8.jpg',
    'assets/spot9.jpg',
    'assets/spot10.jpg'
  ];

  void updateSpotStatus(
      String spot, String name, String licenseNumber, List<int> hours) {
    setState(() {
      int spotIndex = parkingSpots.indexOf(spot);
      if (spotIndex < parkingSpots.length) {
        if (!reservedSpots.contains(spot)) {
          // Spot is reserved
          reservedSpots.add(spot);
        } else {
          // Spot is unreserved
          reservedSpots.remove(spot);
        }
        reservations[spot] = {
          'Name': name,
          'License Number': licenseNumber,
          'Hours': hours
        };
      }
    });
  }

  void viewReservationDetails(
      String spot, String name, String licenseNumber, List<int> hours) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservation Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Spot: $spot'),
              Text('Location: ${widget.location}'),
              Text('Reserved by: $name'),
              Text('License Number: $licenseNumber'),
              Text('Hours: ${hours.join(', ')}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spots at ${widget.location}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: parkingSpots.length,
        itemBuilder: (context, index) {
          final isReserved = reservedSpots.contains(parkingSpots[index]);
          final icon = isReserved ? Icons.block : Icons.check_circle;
          final color = isReserved ? Colors.red : Colors.green;
          return InkWell(
            onTap: () {
              if (!isReserved) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReserveParkingSpot(
                      location: widget.location,
                      spot: parkingSpots[index],
                      onReserved: (name, licenseNumber, hours) {
                        updateSpotStatus(
                            parkingSpots[index], name, licenseNumber, hours);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              } else {
                String name = reservations[parkingSpots[index]]!['Name'] ?? '';
                String licenseNumber =
                    reservations[parkingSpots[index]]!['License Number'] ?? '';
                List<int> hours = List<int>.from(
                    reservations[parkingSpots[index]]!['Hours'] ?? []);
                viewReservationDetails(
                    parkingSpots[index], name, licenseNumber, hours);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    parkingSpots[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    color: isReserved ? Colors.black.withOpacity(0.5) : null,
                    colorBlendMode: isReserved ? BlendMode.darken : null,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: color,
                          size: 40,
                        ),
                        SizedBox(
                            width:
                                8), // Adjust the width according to your preference
                        Text(
                          isReserved ? 'Spot Taken' : 'Spot Available',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
