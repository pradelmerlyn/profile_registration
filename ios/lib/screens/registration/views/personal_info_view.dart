import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../model/registration_model.dart';
import '../widgets/form_step_widget.dart';
import '../widgets/page_header_widget.dart';
import '../../../widgets/custom_datepickerfield.dart';
import '../../../widgets/custom_rounded_button.dart';
import '../../../widgets/custom_textformfields.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView(
      {super.key,
      required this.tabController,
      required this.registration,
      required this.onChanged, 
      required this.firstNameController,
      required this.lastNameController, 
      required this.bdayController, 
      required this.ageController, 
      required this.bioController
    });

  final TabController tabController;
  final RegistrationModel registration;
  final ValueChanged<RegistrationModel> onChanged;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bdayController;
  final TextEditingController ageController;
  final TextEditingController bioController;
  @override
  State<StatefulWidget> createState() => _PersonalInfoView();
}

class _PersonalInfoView extends State<PersonalInfoView>
    with TickerProviderStateMixin {
  final _personalInfoFormKey = GlobalKey<FormState>();



  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  void _next() {
    if (_personalInfoFormKey.currentState!.validate()) {
      final updated = widget.registration.copyWith(
        firstName: widget.firstNameController.text,
        lastName: widget.lastNameController.text,
        bday: widget.bdayController.text,
        age: int.tryParse(widget.ageController.text) ?? 0,
        bio: widget.bioController.text,
      );
      widget.onChanged(updated);
      widget.tabController.animateTo(1);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormStepWidget(
      content: Form(
        key: _personalInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _pagination(),
            const SizedBox(height: 10),
            const PageHeaderWidget(
                title: 'Personal Information',
                description:
                    'Input your personal information. All fields are required.'),
            _PersonalInfoField(
              controller: widget.firstNameController,
              label: 'First Name',
              validator: (value) => validateTitleCase(
                  value: value,
                  errMsg: 'Please use Title Case (e.g., "John Doe")'),
            ),
            _PersonalInfoField(
              controller: widget.lastNameController,
              label: 'Last Name',
              validator: (value) => validateTitleCase(
                  value: value,
                  errMsg: 'Please use Title Case (e.g., "John Doe")'),
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
          ],
        ),
      ),
      buttons: [
        Expanded(
          child: CustomRoundedButton(
            label: 'Next',
            onPressed: _next,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ],
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
        ));
  }
}

class _BirthdayField extends StatelessWidget {
  const _BirthdayField(
      {required this.label,
      required this.bdayController,
      required this.ageController});

  final TextEditingController bdayController;
  final TextEditingController ageController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  final today = DateTime.now();
                  int age = today.year - pickedDate.year;

                  if (today.month < pickedDate.month ||
                      (today.month == pickedDate.month &&
                          today.day < pickedDate.day)) {
                    age--;
                  }
                  if (age > 99) {
                    debugPrint('Invalid Date');
                    bdayController.text = '';
                    ageController.text = '';
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Age cannot be greater than 99.'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  ageController.text = age.toString();
                },
                validator: (value) {
                  debugPrint('birthday : $value');
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
                }),
          ),
        ],
      ),
    );
  }
}

//**  Reusable Functions/Validations */

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
