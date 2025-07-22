import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/presentation/home/screens/home_screen.dart';
import 'package:sprint1_activity/presentation/registration/bloc/registration/registration_bloc.dart';
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
      listener: (context, state) async {
        debugPrint('isSuccesful: ${state.isSubmissionSuccess}');
        debugPrint('isLoading: ${state.isLoading}');

        if (state.isLoading) {
          LoaderWidget.show(context);
        } else {
          LoaderWidget.hide(context);
          if (state.errorMsg.isNotEmpty) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.errorMsg),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
        if (state.isSubmissionSuccess) {
          debugPrint('✅ Submission successful!');
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
                    Navigator.of(context).pop(); // close dialog

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        debugPrint('state errorMsg: ${state.errorMsg}');
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
              userData: context.read<RegistrationBloc>().state.userEntity)
        ]),
      ),
    );
  }
}
