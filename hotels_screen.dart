import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/hotel_model.dart';  // Import the Hotel model
import 'package:travel_guide/widgets/bottom_navigation_bar.dart';

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen({super.key, required this.hotel});

  // Function to launch Google Maps location
  void _launchURL() async {
    if (await canLaunch(hotel.googleLocation)) {
      await launch(hotel.googleLocation);
    } else {
      throw 'Could not open the URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(hotel.imageUrl, fit: BoxFit.cover, height: 250),
              SizedBox(height: 16.0),
              Text(
                hotel.name,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                hotel.address,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: List.generate(hotel.stars, (index) {
                  return Icon(Icons.star, color: Colors.yellow, size: 20);
                }),
              ),
              SizedBox(height: 16.0),
              Text(
                'History:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(hotel.history),
              SizedBox(height: 16.0),
              Text(
                'Facilities:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(hotel.facilities),
              SizedBox(height: 16.0),
              Text(
                'Reviews:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Column(
                children: hotel.reviews.map((review) {
                  return ListTile(
                    title: Text(review),
                    leading: Icon(Icons.star, color: Colors.yellow),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _launchURL,
                child: Text('View on Google Maps'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: 0, // Set the current tab index
        onTap: (int index) {
          // Handle tab switching if necessary
        },
        username: 'Traveler', context: context, // Replace with dynamic username if needed
      ),
    );
  }
}
