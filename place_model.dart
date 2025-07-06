// lib/models/place.dart

class Place {
  String name;
  String description;
  String imageUrl;
  double rating; // Rating of the place, can be a decimal number

  Place({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating, // Rating is now required
  });
}
