import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  const PaginationWidget(
      {super.key, required this.currentStep, required this.pageCnt});
  final int currentStep;
  final int pageCnt;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  ThemeData? _themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(Object context) {
    return Text(
      "${widget.currentStep} out of ${widget.pageCnt}",
      style: _themeData!.textTheme.labelSmall!
          .copyWith(color: _themeData!.colorScheme.onSecondary),
      textAlign: TextAlign.center,
    );
  }
}
