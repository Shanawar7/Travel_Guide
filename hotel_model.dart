class Hotel {
  final String imageUrl;
  final String name;
  final String address;
  final int price;
  final String history;  // Added history
  final String facilities;  // Added facilities
  final int stars;  // Added star rating
  final String googleLocation;  // Added Google Maps location URL
  final List<String> reviews;  // Added reviews
  final double latitude; // Added latitude
  final double longitude; // Added longitude

  Hotel({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.price,
    required this.history,
    required this.facilities,
    required this.stars,
    required this.googleLocation,
    required this.reviews,
    required this.latitude,  // Initialize latitude
    required this.longitude, // Initialize longitude
  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'assets/images/ritz_carlton.jpg',
    name: 'The Ritz-Carlton',
    address: 'Paris, France',
    price: 950,
    history: 'The Ritz-Carlton is a luxury hotel brand known for offering high-end services.',
    facilities: 'Free WiFi, Swimming pool, Spa, Fitness center, Concierge service.',
    stars: 5,
    googleLocation: 'https://www.google.com/maps?q=48.8566,2.3522',  // Correct Google Maps link
    reviews: [
      'Amazing stay, wonderful service!',
      'The best luxury experience.',
      'Highly recommended, 5 stars!',
    ],
    latitude: 48.8566,
    longitude: 2.3522,
  ),
  Hotel(
    imageUrl: 'assets/images/burj_al_arab.jpg',
    name: 'Burj Al Arab',
    address: 'Dubai, UAE',
    price: 1200,
    history: 'Burj Al Arab is one of the most luxurious and iconic hotels in the world.',
    facilities: 'Private beach, 7-star service, Luxury shopping, Helicopter landing pad.',
    stars: 7,
    googleLocation: 'https://www.google.com/maps?q=25.1413,55.1853',  // Correct Google Maps link
    reviews: [
      'Unparalleled luxury, unmatched views!',
      'A once-in-a-lifetime experience.',
      'A truly magnificent hotel.',
    ],
    latitude: 25.1413,
    longitude: 55.1853,
  ),
  Hotel(
    imageUrl: 'assets/images/plaza-hotel.jpg',
    name: 'Plaza Hotel',
    address: 'New York, USA',
    price: 850,
    history: 'The Plaza Hotel has been the symbol of luxury in New York for over 100 years.',
    facilities: 'Luxury rooms, Fine dining, Spa, Pet-friendly, Event venues.',
    stars: 5,
    googleLocation: 'https://www.google.com/maps?q=40.7644,-73.9735',  // Correct Google Maps link
    reviews: [
      'Old-world charm with modern amenities.',
      'A truly classic New York experience.',
      'Great location, excellent service.',
    ],
    latitude: 40.7644,
    longitude: -73.9735,
  ),
  Hotel(
    imageUrl: 'assets/images/hotel_de_crillon.jpg',
    name: 'Hotel de Crillon',
    address: 'Paris, France',
    price: 950,
    history: 'Hotel de Crillon is a historic luxury hotel that has been welcoming guests since 1909.',
    facilities: 'Rooftop bar, Michelin-star restaurant, Spa, Historical architecture.',
    stars: 5,
    googleLocation: 'https://www.google.com/maps?q=48.8682,2.3188',  // Correct Google Maps link
    reviews: [
      'A truly historic and luxurious stay.',
      'Impeccable service and elegance.',
      'An unforgettable experience.',
    ],
    latitude: 48.8682,
    longitude: 2.3188,
  ),
  Hotel(
    imageUrl: 'assets/images/the_langham.jpg',
    name: 'The Langham',
    address: 'London, UK',
    price: 700,
    history: 'The Langham is known for its exquisite luxury and rich history in London.',
    facilities: 'Afternoon tea, Fitness center, Gourmet dining, Wellness center.',
    stars: 5,
    googleLocation: 'https://www.google.com/maps?q=51.5145,-0.1420',  // Correct Google Maps link
    reviews: [
      'Excellent service, perfect location.',
      'A beautiful hotel with a rich history.',
      'One of the best stays I\'ve ever had.',
    ],
    latitude: 51.5145,
    longitude: -0.1420,
  ),
];
