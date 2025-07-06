import 'package:flutter/material.dart';
import 'package:travel_guide/screens/destination_screen.dart'; // Import destination screen
import 'package:travel_guide/models/destination_model.dart'; // Import model for destination

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List of available destinations (this could be dynamic or from a database)
  final List<Destination> destinations = [
    Destination(
      city: 'Paris',
      country: 'France',
      imageUrl: 'assets/images/paris.jpg',
      description: 'City of lights and love.',
      activities: [],
      latitude: 48.8566,
      longitude: 2.3522,
      otherCities: [],
    ),
    Destination(
      city: 'New York',
      country: 'USA',
      imageUrl: 'assets/images/newyork.jpg',
      description: 'The city that never sleeps.',
      activities: [],
      latitude: 40.7128,
      longitude: -74.0060,
      otherCities: [],
    ),
    // Add more destinations or data to search
  ];

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  // List of search results
  List<Destination> _searchResults = [];

  void _search(String query) {
    setState(() {
      _searchResults = destinations
          .where((destination) => destination.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a destination...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _search(_searchController.text);
                  },
                ),
              ),
              onChanged: (query) {
                _search(query);
              },
            ),
            const SizedBox(height: 20),
            // Display search results
            _searchResults.isEmpty
                ? Center(child: Text('No results found'))
                : Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final destination = _searchResults[index];
                  return ListTile(
                    title: Text(destination.city),
                    subtitle: Text(destination.country),
                    onTap: () {
                      // Navigate to the destination details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationScreen(destination: destination),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
