import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/presentation/registration/bloc/contact_info_view/contact_info_view_bloc.dart';
import 'package:sprint1_activity/presentation/registration/bloc/personal_info_view/personal_info_view_bloc.dart';
import 'package:sprint1_activity/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:sprint1_activity/presentation/registration/widgets/pagination_widget.dart';
import 'package:sprint1_activity/presentation/widgets/custom_rounded_button.dart';

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
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    birthdateController.dispose();
    ageController.dispose();
    bioController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          final targetIndex = state.currentStep - 1;
          if (_tabController.index != targetIndex) {
            _tabController.animateTo(targetIndex);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Registration',
              style: _themeData?.textTheme.titleSmall?.copyWith(
                color: _themeData?.colorScheme.tertiary,
              ),
            ),
            elevation: 0,
            centerTitle: true,
          ),
          body: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              final currStep = state.currentStep;
              final label = state.buttonLabel;
              final showBack = currStep > 1;

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
                          create: (_) => PersonalInfoViewBloc(),
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
                          create: (_) => ContactInfoViewBloc(),
                          child: ContactInfoView(
                            formKey: contactInfoFormKey,
                            tabController: _tabController,
                            emailController: emailAddressController,
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                          ),
                        ),
                        ReviewInfoView(tabController: _tabController),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        if (showBack)
                          Expanded(
                            child: CustomRoundedButton(
                              label: 'Back',
                              onPressed: () {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                context
                                    .read<RegistrationBloc>()
                                    .add(PreviousStepEvent());
                              },
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        if (showBack) const SizedBox(width: 10),
                        Expanded(
                          child: CustomRoundedButton(
                            label: label,
                            onPressed: () {
                              context
                                  .read<RegistrationBloc>()
                                  .add(UpdateUserEvent(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    birthday: birthdateController.text,
                                    age: int.tryParse(ageController.text) ?? 0,
                                    email: emailAddressController.text,
                                    bio: bioController.text,
                                  ));

                              if (currStep == 1) {
                                if (personalInfoFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  context
                                      .read<RegistrationBloc>()
                                      .add(NextStepEvent());
                                }
                              } else if (currStep == 2) {
                                if (contactInfoFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  context
                                      .read<RegistrationBloc>()
                                      .add(NextStepEvent());
                                }
                              } else if (currStep == 3) {
                                context
                                    .read<RegistrationBloc>()
                                    .add(GetError());
                                // context
                                //     .read<RegistrationBloc>()
                                //     .add(SubmitFormData());
                              }
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
