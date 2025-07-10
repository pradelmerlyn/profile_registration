// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> showLoadingAnimation({
  required BuildContext context,
  required Future<void> task,
  bool barrierDismissible = false,
  Color color = Colors.blue,
  double size = 100,
}) async {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => Center(
      child: LoadingAnimationWidget.threeRotatingDots(
        color: color,
        size: size,
      ),
    ),
  );

  try {
    await task;
  } finally {
    if (Navigator.of(context).mounted) {
      Navigator.of(context).pop();
    }
  }
}
