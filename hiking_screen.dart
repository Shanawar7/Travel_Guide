import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:travel_guide/widgets/bottom_navigation_bar.dart'; // Import your custom bottom navigation bar

class HikingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> trails = [
    {
      'title': 'Inca Trail, Peru',
      'image': 'assets/images/Incatraail.jpg',
      'description': 'A breathtaking hike leading to the ancient Incan city of Machu Picchu through mountains and cloud forests.',
      'latitude': -13.1631,
      'longitude': -72.5450,
    },
    {
      'title': 'Pacific Crest Trail, USA',
      'image': 'assets/images/Pacificcrest.webp',
      'description': 'Spanning over 2,600 miles, this trail passes through California, Oregon, and Washington.',
      'latitude': 34.2431,
      'longitude': -118.9194,
    },
    {
      'title': 'Torres del Paine Circuit, Chile',
      'image': 'assets/images/Torresdelpaine.jpg',
      'description': 'A spectacular Patagonian trek known for its glaciers, turquoise lakes, and rugged peaks.',
      'latitude': -51.1830,
      'longitude': -73.2425,
    },
    {
      'title': 'Mount Kilimanjaro, Tanzania',
      'image': 'assets/images/Kilimanjaro.jpg',
      'description': 'A challenging yet rewarding hike to the highest peak in Africa with stunning views along the way.',
      'latitude': -3.0674,
      'longitude': 37.3556,
    },
    {
      'title': 'Milford Track, New Zealand',
      'image': 'assets/images/Milfordtrack.jpg',
      'description': 'A scenic trail through lush rainforests, waterfalls, and the stunning fjords of Fiordland National Park.',
      'latitude': -44.6720,
      'longitude': 167.9276,
    },
  ];

  HikingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiking Trails Around the World'),
      ),
      body: ListView.builder(
        itemCount: trails.length,
        itemBuilder: (context, index) {
          final trail = trails[index];
          return GestureDetector(
            onTap: () {
              // Navigate to map screen or launch Google Maps URL on tap
              _launchURL(trail['latitude'], trail['longitude'], trail['title']);
            },
            child: Card(
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
                      trail['image']!,
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
                          trail['title']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Display the description
                        Text(
                          trail['description']!,
                          style: TextStyle(fontSize: 16),
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: 0,
        onTap: (int index) {
          // Handle tab switching if necessary
        },
        username: 'Traveler', // Replace with dynamic username if needed
        context: context,
      ),
    );
  }

  // Function to launch Google Maps URL with latitude and longitude
  Future<void> _launchURL(double latitude, double longitude, String title) async {
    final String googleMapsUrl = "https://www.google.com/maps?q=$latitude,$longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
