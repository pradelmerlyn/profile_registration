import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/screens/widgets/pagination_widget.dart';
import 'package:sprint1_activity/features/widgets/custom_rounded_button.dart';

import '../views/contact_info_view.dart';
import '../views/personal_info_view.dart';
import '../views/review_info_view.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage>
    with TickerProviderStateMixin {
  ThemeData? _themeData;
  late final TabController _tabController;
  final GlobalKey<FormState> personalInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> contactInfoFormKey = GlobalKey<FormState>();

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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

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
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          final currStep = state.currentStep;

          return Column(
            children: [
              // page header
              PaginationWidget(
                currentStep: currStep, 
                pageCnt: _tabController.length
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PersonalInfoView(
                      formKey: personalInfoFormKey,
                      tabController: _tabController,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      bdayController: _birthdateController,
                      ageController: _ageController,
                      bioController: _bioController,
                    ),

                    ContactInfoView(
                      formKey: contactInfoFormKey,
                      tabController: _tabController,
                      emailController: _emailAddressController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                    ),

                    ReviewInfoView(tabController: _tabController),
                  ],
                ),
              ),

              /** TOGGLE BUTTONS  */
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 40,
                ),
                child: _ShowButton(
                  tabController: _tabController,
                  personalInfoFormKey: personalInfoFormKey,
                  contactInfoFormKey: contactInfoFormKey,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  bdayController: _birthdateController,
                  ageController: _ageController,
                  bioController: _bioController,
                  emailController: _emailAddressController,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _ShowButton extends StatelessWidget {
  const _ShowButton({
    required this.tabController,
    required this.firstNameController,
    required this.lastNameController,
    required this.bdayController,
    required this.ageController,
    required this.bioController,
    required this.emailController,
    required this.personalInfoFormKey,
    required this.contactInfoFormKey,
  });
  final TabController tabController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bdayController;
  final TextEditingController ageController;
  final TextEditingController bioController;
  final TextEditingController emailController;
  final GlobalKey<FormState> personalInfoFormKey;
  final GlobalKey<FormState> contactInfoFormKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        final currentStep = state.currentStep;

        debugPrint('🎛️ tabconroller: ${tabController.index}');
        debugPrint('🎛️ currentStep:  $currentStep');
        if (tabController.index != currentStep - 1) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => tabController.animateTo(currentStep - 1));
        }

        switch (currentStep) {
          case 1:
            return CustomRoundedButton(
              label: 'Next',
              onPressed: () {
                if (personalInfoFormKey.currentState!.validate()) {
                  final currentUser =
                      context.read<RegistrationBloc>().state.userEntity;
                  final updatedUser = currentUser
                    .copyWith(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      birthdate: bdayController.text,
                      age: int.tryParse(ageController.text) ?? 0,
                      bio: bioController.text
                    );
                    
                    context.read<RegistrationBloc>().add(UpdateUserEvent(updatedUser));
                    context.read<RegistrationBloc>().add(NextStepEvent());
                }

                //debugPrint('ON NEXT STEP: $currentStep tabController: ${tabController.index} ');
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            );
          case 2:
            debugPrint('💼 CASE 2');
            return Row(children: [
              Expanded(
                child: CustomRoundedButton(
                  label: 'Back',
                  onPressed: () {
                    context.read<RegistrationBloc>().add(PreviousStepEvent());
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomRoundedButton(
                  label: 'Review',
                  onPressed: () {
                    if (contactInfoFormKey.currentState!.validate()) {
                      final currentUser =
                          context.read<RegistrationBloc>().state.userEntity;
                      final updatedUserContact =
                          currentUser.copyWith(email: emailController.text);
                      context
                          .read<RegistrationBloc>()
                          .add(UpdateUserEvent(updatedUserContact));
                      context.read<RegistrationBloc>().add(NextStepEvent());
                    }
                   // debugPrint('ON NEXT STEP: $currentStep tabController: ${tabController.index} ');
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ]);

          case 3:
            debugPrint('💼 CASE 3');
            return Row(children: [
              Expanded(
                child: CustomRoundedButton(
                  label: 'Back',
                  onPressed: () {
                    context.read<RegistrationBloc>().add(PreviousStepEvent());
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomRoundedButton(
                  label: 'Continue',
                  onPressed: () {
                    context.read<RegistrationBloc>().add(SubmitFormData());
                    
                   // debugPrint( 'ON NEXT STEP: $currentStep tabController: ${tabController.index} ');
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ]);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
