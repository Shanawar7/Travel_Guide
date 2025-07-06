import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:travel_guide/widgets/bottom_navigation_bar.dart'; // Import your custom bottom navigation bar

class AdventureScreen extends StatelessWidget {
  final List<Map<String, dynamic>> destinations = [
    {
      'title': 'Skydiving in Dubai, UAE',
      'image': 'assets/images/skydiving.jpg',
      'description': 'Experience the thrill of free-fall with breathtaking views of the Palm Jumeirah and Dubai skyline.',
      'latitude': 25.0774, // Latitude for Skydiving in Dubai
      'longitude': 55.1372, // Longitude for Skydiving in Dubai
    },
    {
      'title': 'Hot Air Balloons in Cappadocia, Turkey',
      'image': 'assets/images/hotairballon.jpg',
      'description': 'Float above the unique rock formations and valleys of Cappadocia during sunrise.',
      'latitude': 38.6433, // Latitude for Cappadocia
      'longitude': 34.8289, // Longitude for Cappadocia
    },
    {
      'title': 'Scuba Diving in the Maldives',
      'image': 'assets/images/scubadiving.webp',
      'description': 'Explore vibrant coral reefs and marine life in the crystal-clear waters of the Maldives.',
      'latitude': 3.2028, // Latitude for Maldives
      'longitude': 73.2207, // Longitude for Maldives
    },
    {
      'title': 'Jeep Riding in Deserts of Dubai, UAE',
      'image': 'assets/images/jeepriding.jpg',
      'description': 'Feel the adrenaline rush as you ride jeeps across the golden dunes of Dubai\'s vast deserts.',
      'latitude': 24.9271, // Latitude for Dubai Desert
      'longitude': 55.1822, // Longitude for Dubai Desert
    },
    {
      'title': 'Underwater Hotels in Maldives',
      'image': 'assets/images/underwaterwater.jpg',
      'description': 'Stay in luxury underwater suites surrounded by marine life for a truly unique experience.',
      'latitude': 3.2028, // Latitude for Maldives Underwater Hotels
      'longitude': 73.2207, // Longitude for Maldives Underwater Hotels
    },
  ];

  AdventureScreen({super.key});

  // Function to launch Google Maps URL with latitude and longitude
  Future<void> _launchURL(double latitude, double longitude) async {
    final String googleMapsUrl = "https://www.google.com/maps?q=$latitude,$longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adventure Travel Destinations'),
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
                // Make the image clickable and open the map
                GestureDetector(
                  onTap: () {
                    _launchURL(destination['latitude'], destination['longitude']); // Launch Google Maps with the destination location
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      destination['image']!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
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
        username: 'Traveler', context: context, // Replace with dynamic username if needed
      ),
    );
  }
}
