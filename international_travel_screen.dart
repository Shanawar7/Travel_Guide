import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:travel_guide/widgets/bottom_navigation_bar.dart';

class InternationalTravelScreen extends StatefulWidget {
  const InternationalTravelScreen({super.key});

  @override
  _InternationalTravelScreenState createState() =>
      _InternationalTravelScreenState();
}

class _InternationalTravelScreenState extends State<InternationalTravelScreen> {
  final List<Map<String, dynamic>> historyDestinations = [
    {
      'title': 'Athens, Greece',
      'image': 'assets/images/athens.webp',
      'description': 'Known as the cradle of Western civilization...',
      'location': 'https://goo.gl/maps/R4TqFbfw9yTntCEX6',
      'latitude': 37.9838,
      'longitude': 23.7275,
    },
    {
      'title': 'Cairo, Egypt',
      'image': 'assets/images/cairo.jpg',
      'description': 'A city with a timeless history...',
      'location': 'https://goo.gl/maps/s8Um7ht6wLrkEzY27',
      'latitude': 30.0444,
      'longitude': 31.2357,
    },
  ];

  final List<Map<String, dynamic>> islandDestinations = [
    {
      'title': 'Maldives',
      'image': 'assets/images/maldives.jpg',
      'description': 'Famous for its crystal-clear waters...',
      'location': 'https://goo.gl/maps/XEYZsEV6fBrEjSCo6',
      'latitude': 3.2028,
      'longitude': 73.2207,
    },
    {
      'title': 'Bora Bora, French Polynesia',
      'image': 'assets/images/borabora.webp',
      'description': 'Known for its turquoise lagoons...',
      'location': 'https://goo.gl/maps/Ks33WG1Db4zLwpr99',
      'latitude': -16.5000,
      'longitude': -151.7415,
    },
  ];

  final List<Map<String, dynamic>> mountainDestinations = [
    {
      'title': 'Switzerland',
      'image': 'assets/images/switzerland.jpg',
      'description': 'Offers picturesque Alpine landscapes...',
      'location': 'https://goo.gl/maps/RfApchJ5N8EktYcP7',
      'latitude': 46.8182,
      'longitude': 8.2275,
    },
    {
      'title': 'Nepal',
      'image': 'assets/images/nepal.jpg',
      'description': 'Home to the Himalayas...',
      'location': 'https://goo.gl/maps/9jzk98VVrJ9SvEpt9',
      'latitude': 27.7172,
      'longitude': 85.3240,
    },
  ];

  Future<void> _launchURL(double latitude, double longitude) async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

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
        title: Text('International Travel Destinations'),
      ),
      body: ListView(
        children: <Widget>[
          _buildSectionHeader('History-Related Destinations'),
          ...historyDestinations.map((destination) {
            return _buildDestinationCard(destination);
          }),
          _buildSectionHeader('Beautiful Island Destinations'),
          ...islandDestinations.map((destination) {
            return _buildDestinationCard(destination);
          }),
          _buildSectionHeader('Mountain Destinations'),
          ...mountainDestinations.map((destination) {
            return _buildDestinationCard(destination);
          }),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: 0,
        onTap: (int index) {
          print('Selected Tab: $index');
        },
        username: 'Traveler',
        context: context,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.blueAccent[100],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> destination) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _launchURL(destination['latitude'], destination['longitude']);
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
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination['title']!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 5),
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
  }
}
