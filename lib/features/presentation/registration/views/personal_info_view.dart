import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/personal_info_view/bloc/personal_info_view_bloc.dart';
import 'package:sprint1_activity/features/widgets/custom_datepickerfield.dart';
import 'package:sprint1_activity/features/widgets/custom_textformfields.dart';

import '../widgets/form_step_widget.dart';
import '../widgets/page_header_widget.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({
    super.key,
    required this.tabController,
    required this.firstNameController,
    required this.lastNameController,
    required this.bdayController,
    required this.ageController,
    required this.bioController,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final TabController tabController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bdayController;
  final TextEditingController ageController;
  final TextEditingController bioController;

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  PersonalInfoViewBloc? _bloc;

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc ??= context.read<PersonalInfoViewBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return FormStepWidget(
      content: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const PageHeaderWidget(
              title: 'Personal Information',
              description:
                  'Input your personal information. All fields are required.',
            ),
            _PersonalInfoField(
              controller: widget.firstNameController,
              label: 'First Name',
              validator: (value) => _bloc!.validateTitleCase(
                value: value,
                errMsg: 'Please use Title Case (e.g., "John Doe")',
              ),
            ),
            _PersonalInfoField(
              controller: widget.lastNameController,
              label: 'Last Name',
              validator: (value) => _bloc!.validateTitleCase(
                value: value,
                errMsg: 'Please use Title Case (e.g., "John Doe")',
              ),
            ),
            _BirthdayField(
              label: 'Birthday',
              bdayController: widget.bdayController,
              ageController: widget.ageController,
            ),
            _PersonalInfoField(
              controller: widget.bioController,
              label: 'Bio - Describe yourself.',
              maxLines: 5,
              validator: (value) => _bloc!.validateTitleCase(
                  value: value,
                  errMsg: 'Each word must be in Title Case',)
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalInfoField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  const _PersonalInfoField({
    required this.controller,
    required this.validator,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        controller: controller,
        label: label,
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        validator: validator,
      ),
    );
  }
}

class _BirthdayField extends StatelessWidget {
  const _BirthdayField({
    required this.label,
    required this.bdayController,
    required this.ageController,
  });

  final TextEditingController bdayController;
  final TextEditingController ageController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoViewBloc, PersonalInfoViewState>(
      listenWhen: (previous, current) =>
          previous.birthday != current.birthday ||
          previous.age != current.age ||
          previous.errorId != current.errorId,
      listener: (context, state) {
        if (!context.mounted) return;

        if (state.birthdayError.isNotEmpty) {
          bdayController.text = '';
          ageController.text = '';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.birthdayError,
                style: const TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
            ),
          );
        } else {
          bdayController.text = state.birthday;
          ageController.text = state.age > 0 ? state.age.toString() : '';
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomDatePickerField(
                label: label,
                controller: bdayController,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                onDateChanged: (pickedDate) {
                  context
                      .read<PersonalInfoViewBloc>()
                      .add(ValidateBirthdayEvent(pickedDate));
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
              width: 120,
              child: CustomTextFormField(
                label: 'Age',
                controller: ageController,
                readOnly: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
