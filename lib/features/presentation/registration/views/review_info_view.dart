import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1_activity/features/domain/entities/registration/user_entity.dart';
import 'package:sprint1_activity/features/presentation/home/screens/home_screen.dart';
import 'package:sprint1_activity/features/presentation/registration/bloc/registration/registration_bloc.dart';
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
                    context.read<RegistrationBloc>().add(ResetSubmissionSuccess());
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
      },
      child: FormStepWidget(
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          const PageHeaderWidget(
            title: 'Review Information',
            description: 'Please review your information before you continue.',
          ),
          _DisplayFormData(
              userData: context.read<RegistrationBloc>().state.userEntity)
        ]),
      ),
    );
  }
}

class _DisplayFormData extends StatelessWidget {
  final UserEntity userData;

  const _DisplayFormData({required this.userData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = userData.toJson();

    if (kDebugMode) {
      debugPrint('DATA 💘💘 : $data');
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...data.entries.where((e) => e.key != 'bio').map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${_formatKey(e.key)}:',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${e.value}',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          const SizedBox(height: 12),
          if (data.containsKey('bio'))
            RichText(
              text: TextSpan(
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: [
                  const TextSpan(
                    text: 'Bio - Describe yourself: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: data['bio']),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    return key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .replaceAll('_', ' ')
        .trim()
        .split(' ')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}

