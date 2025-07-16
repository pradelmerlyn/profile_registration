import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/contact_info_view/contact_info_view_bloc.dart';

import '../../../../widgets/custom_textformfields.dart';
import '../widgets/form_step_widget.dart';
import '../widgets/page_header_widget.dart';

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({
    super.key,
    required this.tabController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  final TabController tabController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<StatefulWidget> createState() => _ContactInfoView();
}

class _ContactInfoView extends State<ContactInfoView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                title: 'Email & Password', description: 'Login Information'),
            _EmailFormField(label: 'Email', controller: widget.emailController),
            _PasswordFormField(
              label: 'Password',
              controller: widget.passwordController,
              formKey: widget.formKey,
              // onPasswordChanged: () {
              //   setState(
              //       () {}); // triggers rebuild so ConfirmPasswordField sees updated password
              // },
            ),
            _ConfirmPasswordField(
              label: 'Confirm Password',
              controller: widget.confirmPasswordController,
              formKey: widget.formKey,
              passwordController: widget.passwordController
            ),
          ],
        ),
      ),
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
  //final VoidCallback onPasswordChanged;

  const _PasswordFormField({
    required this.label,
    required this.controller,
    required this.formKey,
    // required this.onPasswordChanged,
  });

  @override
  State<_PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<_PasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ContactInfoViewBloc, ContactInfoViewState>(
        buildWhen: (previous, current) =>
            previous.obscurePassword != current.obscurePassword,
        builder: (context, state) {
          bool showPassword = state.obscurePassword;
          return CustomTextFormField(
            label: widget.label,
            controller: widget.controller,
            obscureText: showPassword,
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                context.read<ContactInfoViewBloc>().add(ShowPasswordEvent());
              },
            ),
            onChanged: (value) {
              if (widget.formKey.currentState != null) {
                widget.formKey.currentState!.validate();
              }
              // widget.onPasswordChanged();
            },
            validator: _validatePassword,
          );
        },
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
  final TextEditingController passwordController;
  final String label;
  final GlobalKey<FormState> formKey;

  const _ConfirmPasswordField({
    required this.label,
    required this.controller,
    required this.formKey,
    required this.passwordController,
  });

  @override
  State<StatefulWidget> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<_ConfirmPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ContactInfoViewBloc, ContactInfoViewState>(

        buildWhen: (previous, current) =>
            previous.obscureConfirmPassword != current.obscureConfirmPassword,

        builder: (context, state) {
          bool showConfirmPassword = state.obscureConfirmPassword;
          return CustomTextFormField(
            label: widget.label,
            controller: widget.controller,
            obscureText: showConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                showConfirmPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                context
                    .read<ContactInfoViewBloc>()
                    .add(ShowConfirmPasswordEvent());
              },
            ),
            onChanged: (value) {
              if (widget.formKey.currentState != null) {
                widget.formKey.currentState!.validate();
              }
            },
            validator: (value) => _validateConfirmPassword(value),
          );
        },
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != widget.passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
