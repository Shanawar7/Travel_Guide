import 'package:flutter/material.dart';
import 'package:travel_guide/models/activity_model.dart';
import 'package:travel_guide/models/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'activity_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:travel_guide/widgets/bottom_navigation_bar.dart';

class DestinationScreen extends StatefulWidget {
  final Destination destination;

  const DestinationScreen({super.key, required this.destination});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  double _imageHeight = 600.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination.city),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageSection(),
            const SizedBox(height: 20.0),
            _buildDetailsSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: 0, // Set the current tab index
        onTap: (int index) {
          // Handle tab switching if necessary
        },
        username: 'Traveler', // Replace with dynamic username if needed
        context: context,
      ),
    );
  }

  // **Image Section with Animation**
  Widget _buildImageSection() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _imageHeight = _imageHeight == 600.0 ? 500.0 : 600.0;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: double.infinity,
            height: _imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                image: AssetImage(widget.destination.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 20.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.destination.city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 15.0,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    widget.destination.country,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // **Details Section**
  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.destination.city}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 100.0,
            child: SingleChildScrollView(
              child: Text(
                widget.destination.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cities to Visit',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                  size: 30.0,
                ),
                onPressed: _openMap,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          _buildActivitiesList(),
        ],
      ),
    );
  }

  // **Activities List**
  Widget _buildActivitiesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.destination.activities.length,
      itemBuilder: (context, index) {
        CityActivity activity = widget.destination.activities[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ActivityDetailScreen(activity: activity),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(activity.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        activity.type,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        activity.description,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // **Open Map using Google Maps**
  void _openMap() async {
    String mapsUrl = "https://www.google.com/maps/dir/?api=1&destination="
        "${widget.destination.latitude},${widget.destination.longitude}";

    for (var city in widget.destination.otherCities) {
      mapsUrl += "&waypoints=${city.latitude},${city.longitude}";
    }

    if (await canLaunchUrl(Uri.parse(mapsUrl))) {
      await launchUrl(Uri.parse(mapsUrl));
    } else {
      throw "Could not launch Google Maps.";
    }
  }
}
