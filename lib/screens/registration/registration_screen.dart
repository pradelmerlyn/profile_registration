import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint1_activity/model/registration_model.dart';
import 'package:sprint1_activity/screens/registration/landing_screen.dart';
import 'package:sprint1_activity/widgets/custom_datepickerfield.dart';
import 'package:sprint1_activity/widgets/custom_loading_animation.dart';
import 'package:sprint1_activity/widgets/custom_rounded_button.dart';
import 'package:sprint1_activity/widgets/custom_textformfields.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  ThemeData? _themeData;
  final _personalInfoFormKey = GlobalKey<FormState>();
  final _contactInfoFormKey = GlobalKey<FormState>();

  // personal info
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // contact info
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  late final TabController _tabController;
  RegistrationModel? _registration;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    // personal info
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdateController.dispose();
    _ageController.dispose();
    _bioController.dispose();

    // contact info
    _emailAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration',
              style: _themeData!.textTheme.titleSmall?.copyWith(
                color: _themeData!.colorScheme.tertiary,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _personalInfoPage(),
            _contactInfoPage(),
            _reviewPage(),
          ],
        ));
  }

  Widget buildStepPage({
    required Widget content,
    required List<Widget> buttons,
  }) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: content,
            ),
          ),

          // Fixed bottom buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: buttons,
            ),
          )
        ],
      ),
    );
  }

  /// **   PERSONAL INFO PAGE  **
  Widget _personalInfoPage() {
    return buildStepPage(
      content: Form(
        key: _personalInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pagination(),
            const SizedBox(height: 10),
            _pageHeader(
                title: 'Personal Information',
                description:
                    'Input your personal information. All fields are required.'),
            _firstNameField(),
            _lastNameField(),
            _birthdayField(),
            _bioField(),
          ],
        ),
      ),
      buttons: [
        Expanded(
          child: CustomRoundedButton(
            label: 'Next',
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              if (_personalInfoFormKey.currentState!.validate()) {
                _registration = RegistrationModel(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  bday: _birthdateController.text,
                  age: int.parse(_ageController.text),
                  email: '',
                  bio: _bioController.text,
                );
                debugPrint('📗📗📗 form data: $_registration');
                _tabController.animateTo(1);
              }
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

// Personal Information form widgets
  Widget _firstNameField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextFormField(
          controller: _firstNameController,
          label: 'First Name',
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          validator: (value) => validateTitleCase(
              value: value, errMsg: 'Please use Title Case (e.g., "John Doe")'),
        ),
      );

  Widget _lastNameField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextFormField(
          controller: _lastNameController,
          label: 'Last Name',
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
          ],
          validator: (value) => validateTitleCase(
              value: value, errMsg: 'Please use Title Case (e.g., "John Doe")'),
        ),
      );

  Widget _birthdayField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomDatePickerField(
                  label: 'Birthday',
                  controller: _birthdateController,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChanged: (pickedDate) {
                    final today = DateTime.now();
                    int age = today.year - pickedDate.year;
                    if (today.month < pickedDate.month ||
                        (today.month == pickedDate.month &&
                            today.day < pickedDate.day)) {
                      age--;
                    }
                    _ageController.text = age.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your birthday';
                    }
                    return null;
                  }),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 120,
              child: CustomTextFormField(
                  label: "Age",
                  controller: _ageController,
                  readOnly: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  }),
            ),
          ],
        ),
      );

  Widget _bioField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextFormField(
            controller: _bioController,
            textCapitalization: TextCapitalization.words,
            label: 'Bio - Describe yourself.',
            maxLines: 5,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Bio is required';
              }

              final titleCaseError = validateTitleCase(
                  value: value, errMsg: 'Each word must be in Title Case');
              if (titleCaseError != null) {
                return titleCaseError;
              }
              return null;
            }),
      );

  /// **   CONTACT INFO PAGE  **

  Widget _contactInfoPage() {
    return buildStepPage(
      content: Form(
        key: _contactInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pagination(),
            const SizedBox(height: 10),
            _pageHeader(
                title: 'Email & Password', description: 'Login Information'),
            _emailField(),
            _passwordField(),
            _confirmPasswordField(),
          ],
        ),
      ),
      buttons: [
        Expanded(
          child: CustomRoundedButton(
            label: 'Back',
            onPressed: () => _tabController.animateTo(0),
            backgroundColor: _themeData!.colorScheme.onSecondary,
            foregroundColor: _themeData!.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomRoundedButton(
            label: 'Review',
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');

              if (_contactInfoFormKey.currentState!.validate()) {
                setState(() {
                   _registration = _registration!
                      .copyWith(email: _emailAddressController.text);
                });
               

                debugPrint('📕 Registration Form data: ${_registration!.toJson()}');
                _tabController.animateTo(2);
              }
            },
            backgroundColor: _themeData!.colorScheme.primary, // blue background
            foregroundColor: _themeData!.colorScheme.onPrimary, // white text
          ),
        ),
      ],
    );
  }

// Contact Information form widgets

  Widget _emailField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextFormField(
          label: 'Email',
          controller: _emailAddressController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            // Email pattern validation
            final emailRegex = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            );
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      );

  Widget _passwordField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextFormField(
          label: 'Password',
          controller: _passwordController,
          obscureText: !_showPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
          onChanged: (value) {
            if (_contactInfoFormKey.currentState != null) {
              _contactInfoFormKey.currentState!.validate();
            }
          },
          validator: _validatePassword,
        ),
      );

  Widget _confirmPasswordField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: (CustomTextFormField(
          label: 'Confirm Password',
          controller: _confirmPasswordController,
          obscureText: !_showConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _showConfirmPassword = !_showConfirmPassword;
              });
            },
          ),
          onChanged: (value) {
            if (_contactInfoFormKey.currentState != null) {
              _contactInfoFormKey.currentState!.validate();
            }
          },
          validator: _validateConfirmPassword,
        )),
      );

  /// **   REVIEW PAGE  **
  Widget _reviewPage() {
    return buildStepPage(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pagination(),
          const SizedBox(height: 10),
          _pageHeader(
              title: 'Review Information',
              description:
                  'Please review your information before you continue.'),
          _displayFormData(),
        ],
      ),
      buttons: [
        Expanded(
          child: CustomRoundedButton(
            label: 'Back',
            onPressed: () => _tabController.animateTo(1),
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomRoundedButton(
            label: 'Continue',
            onPressed: () {
              showLoadingAnimation(
                context: context,
                task: Future.delayed(const Duration(seconds: 2)),
              ).then((_) {
                if (!mounted) return; // make sure context is still valid
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingScreen(),
                  ),
                );
              });
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _displayFormData() {
    final registration = RegistrationModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      bday: _birthdateController.text,
      age: int.tryParse(_ageController.text.trim()) ?? 0,
      email: _emailAddressController.text,
      bio: _bioController.text,
    );

    final data = registration.toJson();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...data.entries.where((e) => e.key != 'bio').map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${_formatKey(e.key)}:',
                          style: _themeData!.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${e.value}',
                          style: _themeData!.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          const SizedBox(height: 12),
          if (data.containsKey('bio'))
            RichText(
              text: TextSpan(
                style: _themeData!.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: [
                  const TextSpan(
                    text: 'Bio - Describe yourself: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: data['bio']),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Convert camelCase or snake_case to Title Case in Review Page
  String _formatKey(String key) {
    return key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .replaceAll('_', ' ')
        .trim()
        .split(' ')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  // validate TitleCase
  String? validateTitleCase({
    String? value,
    String? errMsg,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    final words = value.trim().split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.isEmpty) continue;

      final firstLetter = word[0];
      final rest = word.substring(1);

      if (firstLetter != firstLetter.toUpperCase() ||
          rest != rest.toLowerCase()) {
        return errMsg;
      }
    }

    return null; // Valid
  }

  // Password and Confim password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

// Reusable widgets

  Widget _pagination() {
    return Center(
      child: Text(
        "${_tabController.index + 1} out of ${_tabController.length}",
        style: _themeData!.textTheme.labelSmall!
            .copyWith(color: _themeData!.colorScheme.onSecondary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _pageHeader({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: _themeData!.textTheme.titleSmall,
          ),
          Text(
            description,
            style: _themeData!.textTheme.bodyMedium!
                .copyWith(color: _themeData!.colorScheme.onSecondary),
          ),
        ],
      ),
    );
  }
}
