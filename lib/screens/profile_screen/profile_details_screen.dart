import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60), // To make room for avatar

          _buildProfileHeader(),
          const SizedBox(height: 60), // To make room for avatar
          _profileInfo(),
          _buildAboutMe(),
          _buildButton(context),
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

Widget _buildProfileHeader() {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      // Header background
      Container(
        height: 320,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile_pic.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: const Color.fromARGB(255, 251, 113, 95)
              .withOpacity(0.5), // purple overlay
        ),
      ),

      // Profile image
      const Positioned(
        bottom: -50,
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
    margin: const EdgeInsets.only(top: 20),
    // decoration: BoxDecoration(
    //   color: Colors.white,
    //   borderRadius: BorderRadius.circular(12),
    //   boxShadow: [
    //     BoxShadow(
    //       color: Colors.black.withOpacity(0.1),
    //       blurRadius: 10,
    //       offset: const Offset(0, 5),
    //     ),
    //   ],
    // ),
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
          'Front-end developer with 12 years of experience building responsive and user-friendly web interfaces.\nCurrently expanding my skill set by diving into Flutter development to create seamless cross-platform mobile applications.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

Widget _buildButton(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.red),
    ),
    child: const Text(
      'Back',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  );
}
