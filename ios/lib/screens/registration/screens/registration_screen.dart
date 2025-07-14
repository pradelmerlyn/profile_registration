import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../model/registration_model.dart';
import '../views/contact_info_view.dart';
import '../views/personal_info_view.dart';
import '../views/review_info_view.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  ThemeData? _themeData;
  late RegistrationModel _registration;

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

  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _registration = const RegistrationModel(
        firstName: '', lastName: '', bday: '', age: 0, email: '', bio: '');

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

    //contact info
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
        body: Column(
          children: [
            Text(
              "${_tabController.index + 1} out of ${_tabController.length}",
              style: _themeData!.textTheme.labelSmall!
                  .copyWith(color: _themeData!.colorScheme.onSecondary),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  
                  PersonalInfoView(
                    tabController: _tabController,
                    registration: _registration,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    bdayController: _birthdateController,
                    ageController: _ageController,
                    bioController: _bioController,
                    onChanged: (updated) => setState(() {
                      _registration = updated;
                      debugPrint(
                          '📄 Updated Registration (PersonalInfo): ${_registration.toJson()}');
                    }),
                  ),
                  ContactInfoView(
                    tabController: _tabController,
                    registration: _registration,
                    emailController: _emailAddressController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onChanged: (updated) => setState(() {
                      _registration = updated;
                      debugPrint(
                          '📄 Updated Registration (ContactInfo): ${_registration.toJson()}');
                    }),
                  ),
                  ReviewInfoView(
                    tabController: _tabController,
                    registration: _registration
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
