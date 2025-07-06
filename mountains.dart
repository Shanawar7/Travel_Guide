import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/bottom_navigation_bar.dart'; // Import your custom bottom navigation bar
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class MountainsScreen extends StatefulWidget {
  const MountainsScreen({super.key});

  @override
  _MountainsScreenState createState() => _MountainsScreenState();
}

class _MountainsScreenState extends State<MountainsScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> mountains = [
    {
      'title': 'Mount Everest, Nepal/Tibet',
      'image': 'assets/images/mounteverest.jpg',
      'description': 'The highest mountain on Earth, standing at 8,848 meters, attracting mountaineers from around the world.',
      'latitude': 27.9881,
      'longitude': 86.9250,
    },
    {
      'title': 'K2, Pakistan/China',
      'image': 'assets/images/K2.webp',
      'description': 'The second-highest mountain in the world, known for its challenging ascent and rugged terrain.',
      'latitude': 35.8825,
      'longitude': 76.5133,
    },
    {
      'title': 'Nanga Parbat, Pakistan',
      'image': 'assets/images/Nangaparbat.jpg',
      'description': 'The ninth-highest mountain in the world, known as the "Killer Mountain" due to its treacherous ascent and challenging conditions.',
      'latitude': 35.2375,
      'longitude': 74.5892,
    },
    {
      'title': 'Matterhorn, Switzerland/Italy',
      'image': 'assets/images/Matterhorn.webp',
      'description': 'One of the most iconic mountains in the world, famous for its pyramid-like shape and extreme climbing routes.',
      'latitude': 45.9763,
      'longitude': 7.6586,
    },
    {
      'title': 'Denali (Mount McKinley), USA',
      'image': 'assets/images/Denali.webp',
      'description': 'The highest peak in North America, known for its extreme weather conditions and challenging climbs.',
      'latitude': 63.0695,
      'longitude': -151.0068,
    },
  ];

  // Function to launch Google Maps using latitude and longitude
  Future<void> _launchURL(double latitude, double longitude) async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mountains Around the World'),
      ),
      body: ListView.builder(
        itemCount: mountains.length,
        itemBuilder: (context, index) {
          final mountain = mountains[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the image and make it clickable
                GestureDetector(
                  onTap: () {
                    _launchURL(mountain['latitude'], mountain['longitude']);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      mountain['image']!,
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
                        mountain['title']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      // Display the description
                      Text(
                        mountain['description']!,
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
        currentTab: _selectedIndex, // Set the current tab index
        onTap: _onItemTapped, // Handle tab switching
        username: 'Traveler', // Replace with dynamic username if needed
        context: context, // Pass context for navigation if needed
      ),
    );
  }
}
