import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint1_activity/widgets/custom_datepickerfield.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        title: Text(
          'Registration',
          style: _themeData!.textTheme.titleSmall?.copyWith(
              color: _themeData!.colorScheme.tertiary,
              fontWeight: FontWeight.normal),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '1 out of 3'),
            Tab(text: '2 out of 3'),
            Tab(text: '3 out of 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildPersonalInfoForm(),
          _buildContactInfo(),
          Center(child: Text("It's sunny here")),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoForm() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
        child: Form(
          key: _personalInfoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                  "Input your personal information. All fields are required."),
              const SizedBox(height: 20),

              // First Name
              CustomTextFormField(
                controller: _firstNameController,
                label: 'First Name',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Last Name
              CustomTextFormField(
                controller: _lastNameController,
                label: 'Last Name',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Birthdate & Age
              Row(
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
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: CustomTextFormField(
                      label: "Age",
                      controller: _ageController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Bio
              CustomTextFormField(
                controller: _bioController,
                label: 'Bio - Describe yourself.',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Next Button
              Center(
                child: CustomRoundedButton(
                  label: 'Next',
                  onPressed: () {
                    debugPrint("tab index: ${_tabController.index}");
                    
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    if (_personalInfoFormKey.currentState!.validate()) {
                      _tabController.animateTo(1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saving Data...')),
                      );
                    }
                  },
                  backgroundColor: _themeData!.colorScheme.primary,
                  foregroundColor: _themeData!.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _contactInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Personal Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text(
                "Input your personal information. All fields are required."),
            const SizedBox(height: 20),

            // Email
            CustomTextFormField(
              controller: _emailAddressController,
              label: 'Email',
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
            const SizedBox(height: 10),

            // Password
            CustomTextFormField(
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            // Confirm Password
            CustomTextFormField(
              label: 'Confirm Password',
              controller: _confirmPasswordController,
              obscureText: !_showConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _showConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _showConfirmPassword = !_showConfirmPassword;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_personalInfoFormKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_personalInfoFormKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
