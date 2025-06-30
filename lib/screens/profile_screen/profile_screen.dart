import 'package:flutter/material.dart';
import 'package:sprint1_activity/screens/profile_screen/profile_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 105,
              backgroundColor: Color.fromARGB(255, 251, 113, 95),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Merlyn Pradel",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "pradel.merlyn@gmail.com",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileDetailsScreen()));
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
              child: const Text('View Details', 
                  style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
