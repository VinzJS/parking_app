import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ReserveParkingSpot extends StatefulWidget {
  final String location;
  final String spot;
  final Function(String, String, List<int>) onReserved;

  ReserveParkingSpot({
    required this.location,
    required this.spot,
    required this.onReserved,
  });

  @override
  _ReserveParkingSpotState createState() => _ReserveParkingSpotState();
}

class _ReserveParkingSpotState extends State<ReserveParkingSpot> {
  String name = '';
  String licenseNumber = '';
  File? selectedImage;
  List<int> selectedHours = [];

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void _showQRCodeDialog(String data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Your QR Code'),
          content: QrImage(
            data: data,
            version: QrVersions.auto,
            size: 200.0,
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
        title: Text('Reserve Spot ${widget.spot} at ${widget.location}'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              if (name.isNotEmpty &&
                  licenseNumber.isNotEmpty &&
                  selectedImage != null &&
                  selectedHours.isNotEmpty) {
                String qrData = 'Name: $name\nLicense: $licenseNumber\nHours: ${selectedHours.join(', ')}';
                _showQRCodeDialog(qrData);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill in all fields and select an image to generate QR code')),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : Icon(Icons.add_a_photo, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text('Enter your information to reserve Spot ${widget.spot}'),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'License Number',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  setState(() {
                    licenseNumber = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Text('Select hours for reservation:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedHours.contains(i)) {
                            selectedHours.remove(i);
                          } else {
                            selectedHours.add(i);
                          }
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedHours.contains(i)
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty &&
                    licenseNumber.isNotEmpty &&
                    selectedImage != null &&
                    selectedHours.isNotEmpty) {
                  widget.onReserved(name, licenseNumber, selectedHours);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Spot Reserved', style: TextStyle(fontSize: 20)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error', style: TextStyle(fontSize: 20)),
                        content: Text('Please fill in all fields, select an image, and choose at least one hour for reservation.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Reserve Spot',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
