import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/domain/model/registration/user_entity.dart';
import 'package:sprint1_activity/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:sprint1_activity/presentation/registration/bloc/user_list/user_list_bloc.dart';
import 'package:sprint1_activity/presentation/registration/screens/user_list_screen.dart';
import 'package:sprint1_activity/presentation/registration/widgets/form_data_widget.dart';
import 'package:sprint1_activity/presentation/registration/widgets/loader_widget.dart';
import '../widgets/form_step_widget.dart';
import '../widgets/page_header_widget.dart';

class ReviewInfoView extends StatefulWidget {
  const ReviewInfoView({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<ReviewInfoView> createState() => _ReviewInfoViewState();
}

class _ReviewInfoViewState extends State<ReviewInfoView>
    with TickerProviderStateMixin {
  ThemeData? _themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoaderWidget.show(context);
        } else {
          LoaderWidget.hide(context);

          if (state.errorMsg.isNotEmpty) {
            final navigator = Navigator.of(context, rootNavigator: true);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.errorMsg),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<RegistrationBloc>().add(ResetErrorMessage());
                      navigator.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      navigator.pop(); // close dialog immediately
                      await _handleRetry(state.userEntity);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.isSubmissionSuccess) {
            final navigator = Navigator.of(context);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: const Text('Success!'),
                content: const Text(
                  'Congratulations, your account has been successfully created.',
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: _themeData!.textTheme.labelLarge,
                    ),
                    child: const Text('OK'),
                    onPressed: () {
                      context
                          .read<RegistrationBloc>()
                          .add(ResetSubmissionSuccess());

                      navigator.pop(); // close success dialog

                      navigator.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                UserListBloc()..add(const FetchUsers()),
                            child: const UserListScreen(),
                          ),
                        ),
                        (_) => false,
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }
      },
      child: FormStepWidget(
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          const PageHeaderWidget(
            title: 'Review Information',
            description: 'Please review your information before you continue.',
          ),
          FormDataWidget(
            userData: context.read<RegistrationBloc>().state.userEntity,
          )
        ]),
      ),
    );
  }

  Future<void> _handleRetry(UserEntity userEntity) async {
    if (!mounted) return;
    LoaderWidget.show(context);
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    context.read<RegistrationBloc>().add(ResetErrorMessage());
    context.read<RegistrationBloc>().add(SubmitFormData(userEntity));
  }
}
