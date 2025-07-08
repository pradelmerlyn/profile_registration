import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 60),
          _profileInfo(),
          _buildAboutMe(),
        ],
      ),
    );
  }
}

Widget _profileInfo() {
  return const Column(
    children: [
      Text(
        "Merlyn Pradel",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Email
      Text(
        "pradel.merlyn@gmail.com",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),

      SizedBox(height: 20),

      // Role
      Text(
        "Flutter Developer",
        style: TextStyle(fontSize: 18),
      ),
    ],
  );
}

Widget _buildProfileHeader(BuildContext context) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      // Header background
      Container(
        height: 300,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile_pic.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: const Color.fromARGB(255, 251, 113, 95).withOpacity(0.5),
        ),
      ),

      // Close button in top-right
      Positioned(
        top: 40,
        left: 16,
        child: _buildCloseButton(context),
      ),

      // Profile image
      const Positioned(
        bottom: -50,
        left: 0,
        right: 0,
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Color.fromARGB(255, 251, 113, 95),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
          ),
        ),
      ),
    ],
  );
}

Widget _buildAboutMe() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'About Me',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Front-end developer with 12 years of experience building responsive and user-friendly web interfaces.'
          '\nCurrently expanding my skill set by diving into Flutter development to create seamless cross-platform mobile applications.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

Widget _buildCloseButton(context) {
  return IconButton(
    icon: const Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
    ),
    color: Colors.black87,
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
