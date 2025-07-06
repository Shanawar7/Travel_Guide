import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/bottom_navigation_bar.dart'; // Import your custom bottom navigation bar
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class NightOutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> destinations = [
    {
      'title': 'Times Square, New York, USA',
      'image': 'assets/images/TimesSquare.jpg',
      'description': 'Bright lights, Broadway shows, and endless entertainment make this a top night-out spot.',
      'latitude': 40.7580,
      'longitude': -73.9855,
    },
    {
      'title': 'Ibiza, Spain',
      'image': 'assets/images/ibiza.jpg',
      'description': 'Famous for its world-class clubs, beach parties, and non-stop dancing till dawn.',
      'latitude': 38.9833,
      'longitude': 1.2583,
    },
    {
      'title': 'Copacabana, Rio de Janeiro, Brazil',
      'image': 'assets/images/Copacabana.jpg',
      'description': 'A lively beachside destination perfect for samba dancing and late-night parties.',
      'latitude': -22.9714,
      'longitude': -43.1822,
    },
    {
      'title': 'Miami, Florida, USA',
      'image': 'assets/images/Miami.webp',
      'description': 'Known for its vibrant nightlife, beach clubs, and Latin-inspired music and dance culture.',
      'latitude': 25.7617,
      'longitude': -80.1918,
    },
    {
      'title': 'Las Vegas, Nevada, USA',
      'image': 'assets/images/Las Vegas.jpg',
      'description': 'The city of lights offers casinos, nightclubs, and world-famous shows for the ultimate night out.',
      'latitude': 36.1699,
      'longitude': -115.1398,
    },
  ];

  NightOutScreen({super.key});

  // Function to open Google Maps with latitude and longitude
  void _openGoogleMaps(double latitude, double longitude) async {
    String mapsUrl = "https://www.google.com/maps/?q=$latitude,$longitude";

    if (await canLaunchUrl(Uri.parse(mapsUrl))) {
      await launchUrl(Uri.parse(mapsUrl));
    } else {
      throw 'Could not open Google Maps.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Night Out Destinations'),
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
                // Wrap the image with GestureDetector to handle tap
                GestureDetector(
                  onTap: () {
                    _openGoogleMaps(
                      destination['latitude'],
                      destination['longitude'],
                    );
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
