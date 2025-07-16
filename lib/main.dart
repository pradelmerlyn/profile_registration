import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/contact_info_view/contact_info_view_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/registration/registration_bloc.dart';
import 'core/custom_theme.dart';
import 'features/presentation/home/screens/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => ContactInfoViewBloc(),
        ),
      ],
      child: MaterialApp(
        theme: CustomAppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
