import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/bottom_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class NationalTravelScreen extends StatelessWidget {
  final List<Map<String, dynamic>> destinations = [
    {
      'title': 'Grand Canyon, USA',
      'image': 'assets/images/grand_canyon.webp',
      'description': 'One of the Seven Natural Wonders of the World, known for its immense size and stunning vistas.',
      'latitude': 36.1069, // Latitude for Grand Canyon
      'longitude': -112.1129, // Longitude for Grand Canyon
    },
    {
      'title': 'Great Barrier Reef, Australia',
      'image': 'assets/images/great_barrier_reef.jpg',
      'description': 'The world’s largest coral reef system, perfect for snorkeling and diving enthusiasts.',
      'latitude': -18.2871, // Latitude for Great Barrier Reef
      'longitude': 147.6992, // Longitude for Great Barrier Reef
    },
    {
      'title': 'Machu Picchu, Peru',
      'image': 'assets/images/machu_picchu.webp',
      'description': 'An ancient Incan city located in the Andes mountains, known for its archaeological significance.',
      'latitude': -13.1631, // Latitude for Machu Picchu
      'longitude': -72.5450, // Longitude for Machu Picchu
    },
    {
      'title': 'Santorini, Greece',
      'image': 'assets/images/Santorini.webp',
      'description': 'Famous for its white-washed buildings, blue domes, and breathtaking sunsets over the Aegean Sea.',
      'latitude': 36.3932, // Latitude for Santorini
      'longitude': 25.4615, // Longitude for Santorini
    },
    {
      'title': 'Mount Fuji, Japan',
      'image': 'assets/images/Mount_Fuji.jpg',
      'description': 'A sacred symbol of Japan and a popular hiking destination, surrounded by stunning lakes and nature.',
      'latitude': 35.3606, // Latitude for Mount Fuji
      'longitude': 138.7274, // Longitude for Mount Fuji
    },
  ];

  // Function to launch Google Maps using coordinates
  Future<void> _launchURL(double latitude, double longitude) async {
    final String url = 'https://www.google.com/maps?q=$latitude,$longitude'; // Google Maps URL format
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  NationalTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('National Travel Destinations'),
      ),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    destination['image']!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the title
                      Text(
                        destination['title']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      // Display the description
                      Text(
                        destination['description']!,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      // Add the location link
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                            destination['latitude'],
                            destination['longitude'],
                          ); // Open Google Maps with coordinates when tapped
                        },
                        child: Text(
                          'View on Map',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: 0, // Set the current tab index
        onTap: (int index) {
          // Handle tab switching if necessary
        },
        username: 'Traveler', // Replace with dynamic username if needed
        context: context, // Pass context for navigation if needed
      ),
    );
  }
}
