import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'activity_model.dart'; // Import the CityActivity class

// Define the OtherCity class
class OtherCity {
  String name;
  double latitude;
  double longitude;

  OtherCity({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

// Define the CityLocation class
class CityLocation {
  String name;
  double latitude;
  double longitude;

  CityLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

// Define the Destination class with a list of CityActivity for activities
class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<CityActivity> activities; // List of CityActivity
  double latitude;
  double longitude;
  List<CityLocation> otherCities; // List of CityLocation

  Destination({
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.description,
    required this.activities, // List of CityActivity
    required this.latitude,
    required this.longitude,
    required this.otherCities,
    // List of CityLocation
  });
}

// Function to calculate map bounds dynamically
LatLngBounds calculateBounds(List<CityLocation> otherCities, Destination destination) {
  double north = destination.latitude;
  double south = destination.latitude;
  double east = destination.longitude;
  double west = destination.longitude;

  for (var city in otherCities) {
    north = city.latitude > north ? city.latitude : north;
    south = city.latitude < south ? city.latitude : south;
    east = city.longitude > east ? city.longitude : east;
    west = city.longitude < west ? city.longitude : west;
  }

  return LatLngBounds(
    northeast: LatLng(north, east),
    southwest: LatLng(south, west),
  );
}

// Map Screen Widget
class MapScreen extends StatelessWidget {
  final Destination destination;

  const MapScreen({Key? key, required this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CityLocation> otherCities = destination.otherCities;

    // Calculate bounds to fit all markers
    LatLngBounds bounds = calculateBounds(otherCities, destination);

    return Scaffold(
      appBar: AppBar(
        title: Text(destination.city),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(destination.latitude, destination.longitude),
          zoom: 5.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          controller.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 50),
          );
        },
        markers: {
          Marker(
            markerId: MarkerId(destination.city),
            position: LatLng(destination.latitude, destination.longitude),
            infoWindow: InfoWindow(
              title: destination.city,
              snippet: destination.description,
            ),
          ),
          ...otherCities.map((city) {
            return Marker(
              markerId: MarkerId(city.name),
              position: LatLng(city.latitude, city.longitude),
              infoWindow: InfoWindow(
                title: city.name,
                snippet: "Explore the beauty of ${city.name}",
              ),
            );
          }).toSet(),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: [
              LatLng(destination.latitude, destination.longitude),
              ...otherCities.map((city) => LatLng(city.latitude, city.longitude)),
            ],
            color: Colors.blue,
            width: 4,
          ),
        },
      ),
    );
  }
}

// Sample data for destinations
List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/beijing.jpg',
    city: 'Beijing',
    country: 'China',
    description: 'Visit China for unforgettable adventure filled with history and modern marvels.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/shanghai.jpg',
        name: 'Shanghai',
        type: 'Modern Metropolis',
        description: 'Explore the bustling metropolis known for its skyline and culture.',
      ),
      CityActivity(
        imageUrl: 'assets/images/hong_kong.jpg',
        name: 'Hong Kong',
        type: 'Cosmopolitan City',
        description: 'A mix of tradition and modernity in this dynamic city.',
      ),
    ],
    latitude: 39.9042,
    longitude: 116.4074,
    otherCities: [
      CityLocation(name: 'Shanghai', latitude: 31.2304, longitude: 121.4737),
      CityLocation(name: 'Hong Kong', latitude: 22.3193, longitude: 114.1694),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/newdelhi.jpg',
    city: 'New Delhi',
    country: 'India',
    description: 'Discover India’s vibrant culture, iconic landmarks, and breathtaking landscapes.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/mumbai.jpg',
        name: 'Mumbai',
        type: 'Megacity – Known as the financial capital of India with a bustling metropolis, Bollywood, and cultural landmarks.',
        description: 'Visit the city of dreams, known for its Bollywood culture and historic landmarks.',
      ),
      CityActivity(
        imageUrl: 'assets/images/taj.png',
        name: 'Agra',
        type: 'Historical City – Home to the Taj Mahal, a city rich in Mughal history and architecture.',
        description: 'Home to the iconic Taj Mahal, a symbol of love and architectural brilliance.',
      ),
      CityActivity(
        imageUrl: 'assets/images/goa.jpg',
        name: 'Goa',
        type: 'Tourist Destination – Famous for its beaches, laid-back lifestyle, and vibrant nightlife.',
        description: 'Relax on the sandy beaches and enjoy the vibrant nightlife of Goa.',
      ),
    ],
    latitude: 28.6139,  // New Delhi latitude
    longitude: 77.2090,  // New Delhi longitude
    otherCities: [
      CityLocation(name: 'Mumbai', latitude: 19.0760, longitude: 72.8777),
      CityLocation(name: 'Agra', latitude: 27.1767, longitude: 78.0081),
      CityLocation(name: 'Goa', latitude: 15.2993, longitude: 74.1240),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/rome.png',
    city: 'Rome',
    country: 'Italy',
    description: 'Explore Italy’s timeless art, historic sites, and world-renowned cuisine.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/venice.jpg',
        name: 'Venice',
        type: 'Historic and Romantic City – Known for its canals, gondolas, and Renaissance-era art and architecture.',
        description: 'Discover the romantic charm of canals, gondolas, and historic architecture.',
      ),
      CityActivity(
        imageUrl: 'assets/images/florence.jpg',
        name: 'Florence',
        type: 'Art and Cultural Hub – The birthplace of the Renaissance, famous for art, museums, and historical landmarks.',
        description: 'Immerse yourself in the Renaissance art and history of Florence.',
      ),
      CityActivity(
        imageUrl: 'assets/images/milan.jpg',
        name: 'Milan',
        type: 'Fashion and Design Capital – A modern city known for its fashion, business districts, and cultural attractions.',
        description: 'Visit the fashion capital, famous for its shopping and cultural landmarks.',
      ),
    ],
    latitude: 41.9028,  // Rome latitude
    longitude: 12.4964,  // Rome longitude
    otherCities: [
      CityLocation(name: 'Venice', latitude: 45.4408, longitude: 12.3155),
      CityLocation(name: 'Florence', latitude: 43.7696, longitude: 11.2558),
      CityLocation(name: 'Milan', latitude: 45.4642, longitude: 9.1900),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/islamabad.jpg',
    city: 'Islamabad',
    country: 'Pakistan',
    description: 'Experience Pakistan’s majestic mountains, rich history, and warm hospitality.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/lahore.jpg',
        name: 'Lahore',
        type: 'Cultural City – A city rich in culture, historic monuments, and diverse cuisine.',
        description: 'Explore the cultural capital, known for its historic sites and delicious food.',
      ),
      CityActivity(
        imageUrl: 'assets/images/gilgit.jpg',
        name: 'Gilgit Baltistan',
        type: 'Natural Beauty – Known for breathtaking landscapes, mountainous terrains, and natural parks.',
        description: 'Marvel at the majestic mountains and serene landscapes of the north.',
      ),
      CityActivity(
        imageUrl: 'assets/images/chitral.jpg',
        name: 'Chitral',
        type: 'Scenic Valley – Known for its natural beauty, valleys, and unique cultural heritage.',
        description: 'Experience the beauty of the valleys and unique traditions in Chitral.',
      ),
      CityActivity(
        imageUrl: 'assets/images/swat.jpg',
        name: 'Swat',
        type: 'Valley of Peace – Known for its lush green landscapes, mountains, and rich history.',
        description: 'Discover the lush green valleys and ancient Buddhist heritage of Swat.',
      ),
    ],
    latitude: 33.6844,  // Islamabad latitude
    longitude: 73.0479,  // Islamabad longitude
    otherCities: [
      CityLocation(name: 'Lahore', latitude: 31.5497, longitude: 74.3436),
      CityLocation(name: 'Gilgit Baltistan', latitude: 35.3, longitude: 75.5),
      CityLocation(name: 'Chitral', latitude: 35.8, longitude: 71.8),
      CityLocation(name: 'Swat', latitude: 35.2, longitude: 72.5),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/seoul.jpg',
    city: 'Seoul',
    country: 'South Korea',
    description: 'Visit South Korea for vibrant cities, stunning nature, and delicious cuisine.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/busan.jpg',
        name: 'Busan',
        type: 'Coastal City – Known for its beautiful beaches, modern port, and vibrant markets.',
        description: 'Enjoy the beautiful beaches and vibrant markets of South Korea\'s second city.',
      ),
      CityActivity(
        imageUrl: 'assets/images/jeju.jpg',
        name: 'Jeju',
        type: 'Island Destination – A volcanic island known for natural beauty, waterfalls, and scenic landscapes.',
        description: 'Visit the stunning volcanic island, known for its natural wonders and relaxed vibe.',
      ),
    ],
    latitude: 37.5665,  // Seoul latitude
    longitude: 126.9780,  // Seoul longitude
    otherCities: [
      CityLocation(name: 'Busan', latitude: 35.1796, longitude: 129.0756),
      CityLocation(name: 'Jeju', latitude: 33.4996, longitude: 126.5312),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/tokyo.jpg',
    city: 'Tokyo',
    country: 'Japan',
    description: 'Discover Japan’s unique blend of ancient traditions and futuristic innovations.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/kyoto.jpg',
        name: 'Kyoto',
        type: 'Cultural and Historic City – Famous for traditional tea houses, temples, and historic architecture.',
        description: 'Step back in time to explore ancient temples and traditional tea houses.',
      ),
      CityActivity(
        imageUrl: 'assets/images/osaka.jpg',
        name: 'Osaka',
        type: 'Modern City with Traditional Charm – Known for street food, modern shopping districts, and ancient castles.',
        description: 'Experience the vibrant street food scene and historic landmarks.',
      ),
      CityActivity(
        imageUrl: 'assets/images/hiroshima.jpg',
        name: 'Hiroshima',
        type: 'Historic and Resilient City – A city with a poignant history of peace and survival, home to historical sites.',
        description: 'Learn about the city history and resilience, while exploring its cultural sites.',
      ),
    ],
    latitude: 35.6762,  // Tokyo latitude
    longitude: 139.6503,  // Tokyo longitude
    otherCities: [
      CityLocation(name: 'Kyoto', latitude: 35.0116, longitude: 135.7681),
      CityLocation(name: 'Osaka', latitude: 34.6937, longitude: 135.5023),
      CityLocation(name: 'Hiroshima', latitude: 34.3853, longitude: 132.4553),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/ankara.jpg',
    city: 'Ankara',
    country: 'Turkey',
    description: 'Explore Turkey’s rich history, diverse landscapes, and vibrant culture.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/istanbul.png',
        name: 'Istanbul',
        type: 'Cultural and Historical Crossroads – A city where East meets West, known for its rich history, mosques, and bazaars.',
        description: 'Explore the unique blend of European and Asian cultures in this historic city.',
      ),
      CityActivity(
        imageUrl: 'assets/images/antalya.jpg',
        name: 'Antalya',
        type: 'Coastal Resort – A popular destination for its beaches, resorts, and ancient ruins.',
        description: 'Relax on the beautiful beaches and explore ancient ruins in this coastal city.',
      ),
      CityActivity(
        imageUrl: 'assets/images/izmir.jpg',
        name: 'Izmir',
        type: 'Aegean Port City – Known for its scenic coastline, historical significance, and modern lifestyle.',
        description: 'Visit the gateway to the Aegean, known for its vibrant culture and historic sites.',
      ),
    ],
    latitude: 39.9334,  // Ankara latitude
    longitude: 32.8597,  // Ankara longitude
    otherCities: [
      CityLocation(name: 'Istanbul', latitude: 41.0082, longitude: 28.9784),
      CityLocation(name: 'Antalya', latitude: 36.8849, longitude: 30.7056),
      CityLocation(name: 'Izmir', latitude: 38.4192, longitude: 27.1287),
    ],
  ),
  Destination(
    imageUrl: 'assets/images/abu_dhabi.jpg',
    city: 'Abu Dhabi',
    country: 'United Arab Emirates',
    description: 'Visit the UAE for luxury, world-class attractions, and breathtaking architecture.',
    activities: [
      CityActivity(
        imageUrl: 'assets/images/dubai.png',
        name: 'Dubai',
        type: 'Global City – Known for its luxurious lifestyle, cutting-edge architecture, and shopping malls.',
        description: 'Marvel at the world’s tallest buildings and luxury attractions in this global city.',
      ),
      CityActivity(
        imageUrl: 'assets/images/sharjah.jpg',
        name: 'Sharjah',
        type: 'Cultural Capital – Focused on history, art, and culture, with numerous museums and galleries.',
        description: 'Discover the cultural heart of the UAE, filled with museums and historic landmarks.',
      ),
      CityActivity(
        imageUrl: 'assets/images/al_ain.jpg',
        name: 'Al Ain',
        type: 'Oasis City – Known for its natural beauty, green landscapes, and historical forts.',
        description: 'Explore the oasis city, known for its lush greenery and historic forts.',
      ),
    ],
    latitude: 24.4539,  // Abu Dhabi latitude
    longitude: 54.3773,  // Abu Dhabi longitude
    otherCities: [
      CityLocation(name: 'Dubai', latitude: 25.276987, longitude: 55.296249),
      CityLocation(name: 'Sharjah', latitude: 25.3533, longitude: 55.3800),
      CityLocation(name: 'Al Ain', latitude: 24.2045, longitude: 55.7447),
    ],
  ),
  // Add other destinations similarly
];