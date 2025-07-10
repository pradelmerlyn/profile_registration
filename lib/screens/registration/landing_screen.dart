import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint1_activity/screens/home/home_screen.dart';
import 'package:sprint1_activity/widgets/custom_rounded_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  ThemeData? _themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Green header
          Container(
            color: const Color.fromRGBO(70, 150, 255, 1),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  'SUCCESS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _themeData!.colorScheme.onPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Message
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Congratulations, your account has been successfully created.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 40),

          CustomRoundedButton(
            label: 'Continue',
            useFullWidth: false,
            width: 200,
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            backgroundColor: _themeData!.colorScheme.primary, // blue background
            foregroundColor: _themeData!.colorScheme.onPrimary, // white text
          ),
        ],
      ),
    );
  }
}
