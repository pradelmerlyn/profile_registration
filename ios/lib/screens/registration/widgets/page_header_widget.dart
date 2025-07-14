import 'package:flutter/material.dart';

class PageHeaderWidget extends StatefulWidget {

  const PageHeaderWidget({
    super.key, 
    required this.title, 
    required this.description
  });
  final String title;
  final String description;

  @override
  State<PageHeaderWidget> createState() => _PageHeaderWidgetState();
}

class _PageHeaderWidgetState extends State<PageHeaderWidget> {
  ThemeData? _themeData;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: _themeData!.textTheme.titleSmall,
          ),
          Text(
            widget.description,
            style: _themeData!.textTheme.bodyMedium!
                .copyWith(color: _themeData!.colorScheme.onSecondary),
          ),
        ],
      ),
    );
  }
}
