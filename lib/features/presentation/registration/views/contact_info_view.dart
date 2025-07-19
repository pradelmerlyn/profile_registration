import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/contact_info_view/contact_info_view_bloc.dart';

import '../../../widgets/custom_textformfields.dart';
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
            ),
            _ConfirmPasswordField(
                label: 'Confirm Password',
                controller: widget.confirmPasswordController,
                formKey: widget.formKey,
                passwordController: widget.passwordController),
          ],
        ),
      ),
    );
  }
}

class _EmailFormField extends StatefulWidget {
  const _EmailFormField({
    required this.label,
    required this.controller,
  });

  final TextEditingController controller;
  final String label;

  @override
  State<_EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<_EmailFormField> {

  ContactInfoViewBloc? _bloc;

  @override
  void initState() {
    _bloc = context.read<ContactInfoViewBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ContactInfoViewBloc, ContactInfoViewState>(
        buildWhen: (previous, current) =>
            previous.emailError != current.emailError,
        builder: (context, state) {
          return CustomTextFormField(
            label: widget.label,
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _bloc!.add(ValidateEmailEvent(
                  value: value, errMsg: 'Please enter valid email address'));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (state.emailError.isNotEmpty) {
                return state.emailError; // return the error set in Bloc
              }
              return null;
            },
          );
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
  ContactInfoViewBloc? _bloc;

  @override
  void initState() {
    _bloc = context.read<ContactInfoViewBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ContactInfoViewBloc, ContactInfoViewState>(
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
                _bloc!.add(ShowPasswordEvent());
              },
            ),
            onChanged: (value) {
              if (widget.formKey.currentState != null) {
                widget.formKey.currentState!.validate();
              }
              // widget.onPasswordChanged();
            },
            validator: (value) => _bloc!.validatePassword(value),
          );
        },
      ),
    );
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

  ContactInfoViewBloc? _bloc;

  @override
  void initState() {
    _bloc = context.read<ContactInfoViewBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ContactInfoViewBloc, ContactInfoViewState>(
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
                _bloc!.add(ShowConfirmPasswordEvent());
              },
            ),
            onChanged: (value) {
              if (widget.formKey.currentState != null) {
                widget.formKey.currentState!.validate();
              }
            },
            validator: (value) => _bloc!.validateConfirmPassword(value, widget.passwordController.text),
          );
        },
      ),
    );
  }

  
}
