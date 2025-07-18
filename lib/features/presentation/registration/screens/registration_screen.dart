import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/contact_info_view/contact_info_view_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/personal_info_view/bloc/personal_info_view_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/widgets/pagination_widget.dart';
import 'package:sprint1_activity/features/widgets/custom_rounded_button.dart';

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
  late final TabController _tabController;
  //RegistrationBloc? _bloc;

  final GlobalKey<FormState> personalInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> contactInfoFormKey = GlobalKey<FormState>();

  // personal info
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // contact info
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // personal info
    firstNameController.dispose();
    lastNameController.dispose();
    birthdateController.dispose();
    ageController.dispose();
    bioController.dispose();

    //contact info
    emailAddressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: Scaffold(
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
                PaginationWidget(
                    currentStep: currStep, pageCnt: _tabController.length),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      BlocProvider(
                        create: (context) => PersonalInfoViewBloc(),
                        child: PersonalInfoView(
                          formKey: personalInfoFormKey,
                          tabController: _tabController,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                          bdayController: birthdateController,
                          ageController: ageController,
                          bioController: bioController,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => ContactInfoViewBloc(),
                        child: ContactInfoView(
                          formKey: contactInfoFormKey,
                          tabController: _tabController,
                          emailController: emailAddressController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                        ),
                      ),
                      ReviewInfoView(tabController: _tabController),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: _ButtonDisplay( 
                    tabController: _tabController,
                    personalInfoFormKey: personalInfoFormKey,
                    contactInfoFormKey: contactInfoFormKey,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    bdayController: birthdateController,
                    ageController: ageController,
                    bioController: bioController,
                    emailController: emailAddressController,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

// Toggle button based on Step
class _ButtonDisplay extends StatelessWidget {
  const _ButtonDisplay({
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
                  final updatedUser = currentUser.copyWith(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      birthdate: bdayController.text,
                      age: int.tryParse(ageController.text) ?? 0,
                      bio: bioController.text);

                  context
                      .read<RegistrationBloc>()
                      .add(UpdateUserEvent(updatedUser));
                  context.read<RegistrationBloc>().add(NextStepEvent());
                }
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
                    foregroundColor: Colors.white),
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
                    foregroundColor: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomRoundedButton(
                  label: 'Continue',
                  onPressed: () {
                    context.read<RegistrationBloc>().add(SubmitFormData());
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
