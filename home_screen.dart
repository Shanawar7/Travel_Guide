import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_guide/screens/beaches.dart';
import 'package:travel_guide/screens/international_travel_screen.dart';
import 'package:travel_guide/screens/night_out_screen.dart';
import 'package:travel_guide/screens/mountains.dart';
import 'package:travel_guide/screens/hiking_screen.dart';
import 'package:travel_guide/screens/adventure.dart';
import 'package:travel_guide/widgets/destination_carousel.dart';
import 'package:travel_guide/widgets/hotel_carousel.dart';
import 'package:travel_guide/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = -1;
  int _currentTab = 0;

  final List<IconData> _icons = [
    FontAwesomeIcons.globe,
    FontAwesomeIcons.moon,
    FontAwesomeIcons.compass,
    FontAwesomeIcons.personHiking,
    FontAwesomeIcons.umbrellaBeach,
    FontAwesomeIcons.mountain,
  ];

  final List<String> _labels = [
    'International',
    'Night Out',
    'Adventure',
    'Hiking',
    'Beach',
    'Mountains',
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InternationalTravelScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = -1;
          });
        });
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NightOutScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = -1;
          });
        });
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdventureScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = -1;
          });
        });
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HikingScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = -1;
          });
        });
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BeachScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = -1;
          });
        });
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MountainsScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = -1;
          });
        });
        break;
    }
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        _onIconTapped(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? Theme.of(context).colorScheme.secondary
                  : const Color(0xFFE7EBEE),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Icon(
              _icons[index],
              size: 25.0,
              color: _selectedIndex == index
                  ? Theme.of(context).primaryColor
                  : const Color(0xFFB4C1C4),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            _labels[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: _selectedIndex == index
                  ? Theme.of(context).primaryColor
                  : const Color(0xFFB4C1C4),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero, // Removed padding
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/homebackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                right: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x66FFFFFF), // Translucent background
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 120.0,
                left: 20.0,
                child: Text(
                  'Uncover the \n World’s Wonders!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _icons
                  .asMap()
                  .entries
                  .map((MapEntry map) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: _buildIcon(map.key),
              ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 40.0),
          DestinationCarousel(),
          const SizedBox(height: 40.0),
          HotelCarousel(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        username: '',
        context: context,
      ),
    );
  }
}