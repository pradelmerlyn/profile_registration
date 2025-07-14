import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../model/registration_model.dart';
import '../../../widgets/custom_loading_animation.dart';
import '../../../widgets/custom_rounded_button.dart';
import '../screens/landing_screen.dart';
import '../widgets/form_step_widget.dart';
import '../widgets/page_header_widget.dart';

class ReviewInfoView extends StatefulWidget {
  final RegistrationModel registration;

  const ReviewInfoView({
    super.key, 
    required this.registration, 
    required this.tabController
  });

  final TabController tabController;

  @override
  State<ReviewInfoView> createState() => _ReviewInfoViewState();
}

class _ReviewInfoViewState extends State<ReviewInfoView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FormStepWidget(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const PageHeaderWidget(
            title: 'Review Information',
            description: 'Please review your information before you continue.',
          ),
          _DisplayFormData(registration: widget.registration),
        ]
      ),
    
      buttons: [
        Expanded(
          child: CustomRoundedButton(
            label: 'Back',
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              widget.tabController.animateTo(1);
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomRoundedButton(
            label: 'Continue',
            onPressed: () {
              showLoadingAnimation(
                context: context,
                task: Future.delayed(const Duration(seconds: 2)),
              ).then((_) {
                if (!mounted) return; // make sure context is still valid
                debugPrint(
                  '📄 Updated Registration (ReviewInfo): ${widget.registration.toJson()}',
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingScreen(),
                  ),
                );
              });
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}

class _DisplayFormData extends StatelessWidget {
  final RegistrationModel registration;

  const _DisplayFormData({required this.registration});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = registration.toJson();

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
