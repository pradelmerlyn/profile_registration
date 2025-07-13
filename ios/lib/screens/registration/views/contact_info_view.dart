import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../model/registration_model.dart';
import '../widgets/form_step_widget.dart';
import '../widgets/page_header_widget.dart';
import '../../../widgets/custom_rounded_button.dart';
import '../../../widgets/custom_textformfields.dart';

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({
    super.key,
    required this.tabController,
    required this.registration,
    required this.onChanged, 
    required this.emailController, 
    required this.passwordController, 
    required this.confirmPasswordController,
  });

  final TabController tabController;
  final RegistrationModel registration;
  final ValueChanged<RegistrationModel> onChanged;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<StatefulWidget> createState() => _ContactInfoView();
}

class _ContactInfoView extends State<ContactInfoView>
    with TickerProviderStateMixin {
  final _contactInfoFormKey = GlobalKey<FormState>();
  ThemeData? _themeData;



  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  void _next() {
    if (_contactInfoFormKey.currentState!.validate()) {
      final updated = widget.registration.copyWith(
        email: widget.emailController.text,
      );
      widget.onChanged(updated);
      widget.tabController.animateTo(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormStepWidget(
      content: Form(
        key: _contactInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //_pagination(),
            const SizedBox(height: 10),
            const PageHeaderWidget(
                title: 'Email & Password', description: 'Login Information'),
            _EmailFormField(label: 'Email', controller: widget.emailController),
            _PasswordFormField(
              label: 'Password',
              controller: widget.passwordController,
              formKey: _contactInfoFormKey,
              onPasswordChanged: () {
                setState(
                    () {}); // triggers rebuild so ConfirmPasswordField sees updated password
              },
            ),

            _ConfirmPasswordField(
              label: 'Confirm Password',
              controller: widget.confirmPasswordController,
              formKey: _contactInfoFormKey,
              originalPassword: widget.passwordController.text,
            ),
          ],
        ),
      ),
      buttons: [
        Expanded(
          child: CustomRoundedButton(
            label: 'Back',
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              widget.tabController.animateTo(0);
            },
            backgroundColor: _themeData!.colorScheme.onSecondary,
            foregroundColor: _themeData!.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 10),
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

class _EmailFormField extends StatelessWidget {
  const _EmailFormField({
    required this.label,
    required this.controller,
  });

  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        label: label,
        controller: controller,
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
  }
}

class _PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPasswordChanged;

  const _PasswordFormField({
    required this.label,
    required this.controller,
    required this.formKey,
    required this.onPasswordChanged,
  });

  @override
  State<_PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<_PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        label: widget.label,
        controller: widget.controller,
        obscureText: _obscureText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        onChanged: (value) {
          if (widget.formKey.currentState != null) {
            widget.formKey.currentState!.validate();
          }
          widget.onPasswordChanged();
        },
        validator: _validatePassword,
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}

class _ConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String originalPassword;
  final GlobalKey<FormState> formKey;

  const _ConfirmPasswordField({
    required this.label,
    required this.controller,
    required this.formKey,
    required this.originalPassword,
  });

  @override
  State<StatefulWidget> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<_ConfirmPasswordField> {
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        label: widget.label,
        controller: widget.controller,
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
          if (widget.formKey.currentState != null) {
            widget.formKey.currentState!.validate();
          }
        },
        validator: (value) => _validateConfirmPassword(value),
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != widget.originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
