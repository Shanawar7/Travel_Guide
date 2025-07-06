import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:travel_guide/widgets/bottom_navigation_bar.dart'; // Import your custom bottom navigation bar

class BeachScreen extends StatelessWidget {
  final List<Map<String, dynamic>> beaches = [
    {
      'title': 'Bondi Beach, Australia',
      'image': 'assets/images/Bondibeach.jpg',
      'description': 'Famous for its golden sand and surf culture, Bondi Beach is a must-visit destination in Sydney.',
      'latitude': -33.8915,
      'longitude': 151.2767,
    },
    {
      'title': 'Maya Bay, Thailand',
      'image': 'assets/images/Mayabay.jpg',
      'description': 'A stunning beach with crystal-clear waters, surrounded by cliffs, famous from the movie "The Beach".',
      'latitude': 7.6758,
      'longitude': 98.7676,
    },
    {
      'title': 'Navagio Beach, Greece',
      'image': 'assets/images/Navagiobeach.jpg',
      'description': 'Also known as Shipwreck Beach, this secluded bay is surrounded by towering white cliffs and clear blue waters.',
      'latitude': 37.8590,
      'longitude': 20.6229,
    },
    {
      'title': 'Waikiki Beach, Hawaii, USA',
      'image': 'assets/images/waikikibeach.webp',
      'description': 'A popular destination for surfers, known for its calm waters and beautiful sunset views.',
      'latitude': 21.2762,
      'longitude': -157.8252,
    },
    {
      'title': 'Grace Bay, Turks and Caicos',
      'image': 'assets/images/Gracebay.jpg',
      'description': 'A pristine beach with white sand and turquoise waters, perfect for swimming and relaxing.',
      'latitude': 21.7996,
      'longitude': -72.1722,
    },
  ];

  BeachScreen({super.key});

  // Function to launch Google Maps with the provided latitude and longitude
  Future<void> _launchGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beaches Around the World'),
      ),
      body: ListView.builder(
        itemCount: beaches.length,
        itemBuilder: (context, index) {
          final beach = beaches[index];
          return GestureDetector(
            onTap: () {
              // Open the map directly when the image is clicked
              _launchGoogleMaps(beach['latitude'], beach['longitude']);
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
                      beach['image']!,
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
                          beach['title']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Display the description
                        Text(
                          beach['description']!,
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
        currentTab: 0, // Set the current tab index
        onTap: (int index) {
          // Handle tab switching if necessary
        },
        username: 'Traveler', context: context, // Replace with dynamic username if needed
      ),
    );
  }
}

