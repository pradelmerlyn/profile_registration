import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../home/screens/home_screen.dart';
import '../../widgets/custom_rounded_button.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 100,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          const Text(
            'SUCCESS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              letterSpacing: 1.5,
            
            ),
            textAlign: TextAlign.center,
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

          Center(
            child: CustomRoundedButton(
              label: 'Continue',
              width: 150, 
              useFullWidth: false, 
              onPressed: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              backgroundColor: _themeData!.colorScheme.primary,
              foregroundColor: _themeData!.colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}
