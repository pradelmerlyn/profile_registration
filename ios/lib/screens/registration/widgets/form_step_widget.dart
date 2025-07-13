import 'package:flutter/material.dart';

class FormStepWidget extends StatelessWidget {
  final Widget content;
  final List<Widget> buttons;

  const FormStepWidget({
    super.key, 
    required this.content, 
    required this.buttons
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: content,
            ),
          ),

          // Fixed bottom buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: buttons,
            ),
          )
        ],
      ),
    );
  }
}


