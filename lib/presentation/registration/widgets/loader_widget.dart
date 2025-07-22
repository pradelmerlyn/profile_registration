import 'package:flutter/material.dart';

class LoaderWidget {
  static bool _isLoaderShown = false;

  static void show(BuildContext context) {
    if (!_isLoaderShown) {
      _isLoaderShown = true;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  static void hide(BuildContext context) {
    if (_isLoaderShown && Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
      _isLoaderShown = false;
    }
  }
}
