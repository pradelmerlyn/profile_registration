import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:sprint1_activity/presentation/registration/bloc/user_list/user_list_bloc.dart';
import 'package:sprint1_activity/presentation/registration/screens/user_list_screen.dart';
import '../../profile/profile_details_screen.dart';
import '../../registration/screens/registration_screen.dart';
import '../../widgets/custom_rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeData? _themeData;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themeData!.colorScheme.onPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hey Wizard!",
                      style: _themeData!.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _themeData!.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileDetailsScreen()));
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/profile_pic.jpg'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    //height: 180,
                  ),
                ),
                Text(
                  "Learn Flutter from scratch and build beautiful, high-performance apps. "
                  "\n Start your journey today and level up your mobile development skills!",
                  style: _themeData!.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Center(
                      child: CustomRoundedButton(
                        label: 'Register Here!',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => RegistrationBloc(),
                                        child: const RegistrationScreen(),
                                      )));
                        },
                        backgroundColor: _themeData!.colorScheme.primary, // red
                        foregroundColor:
                            _themeData!.colorScheme.onPrimary, // white (text/icon)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Center(
                      child: CustomRoundedButton(
                        label: 'View Users',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => UserListBloc(),
                                        child: const UserListScreen(),
                                      ),),);
                        },
                        backgroundColor: _themeData!.colorScheme.primary, // red
                        foregroundColor: _themeData!
                            .colorScheme.onPrimary, // white (text/icon)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
