import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // For handling the picked image file
import 'package:travel_guide/widgets/bottom_navigation_bar.dart'; // Import your CustomBottomNavigationBar

class ProfileScreen extends StatefulWidget {
  final String username;
  final String name;
  final String email;
  final String imageUrl;
  final String? contactNumber;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.contactNumber,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController contactController;
  bool isEditing = false;
  late String profileImageUrl;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile; // Store the selected image file

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    usernameController = TextEditingController(text: widget.username);
    contactController = TextEditingController(text: widget.contactNumber ?? '');
    profileImageUrl = widget.imageUrl; // Initialize profileImageUrl with widget's imageUrl
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  // Function to pick a new image
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Store the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Centers the title
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                if (!isEditing) {
                  // Save changes if needed
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image section
            Center(
              child: GestureDetector(
                onTap: isEditing ? _pickImage : null, // Allow image editing only in edit mode
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: _imageFile == null
                      ? NetworkImage(profileImageUrl)
                      : FileImage(_imageFile!) as ImageProvider,
                ),
              ),
            ),
            SizedBox(height: 20),
            isEditing
                ? TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            )
                : Text('Name: ${widget.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            isEditing
                ? TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            )
                : Text('Email: ${widget.email}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            isEditing
                ? TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            )
                : Text('Username: ${widget.username}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            isEditing
                ? TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            )
                : widget.contactNumber != null
                ? Text('Contact Number: ${widget.contactNumber}', style: TextStyle(fontSize: 16))
                : Text('Contact Number: Not Provided', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/welcome_screen'); // Navigate to welcome screen
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF7E5CAD),
                ),
                child: Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: 2,
        onTap: (index) {
          // Handle the navigation logic when bottom navigation item is tapped
          if (index == 0) {
            // Navigate to search
          } else if (index == 1) {
            // Navigate to home page
          }
        },
        username: widget.username, context: context,
      ),
    );
  }
}
