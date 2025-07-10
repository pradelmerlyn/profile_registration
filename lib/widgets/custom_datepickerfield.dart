import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime)? onDateChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.controller,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onDateChanged,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final DateTime now = DateTime.now();
            DateTime initial = now;

            if (controller.text.isNotEmpty) {
              try {
                initial = DateFormat('MM/dd/yyyy').parse(controller.text);
              } catch (e) {
                initial = initialDate ?? now;
              }
            } else {
              initial = initialDate ?? now;
            }

            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initial,
              firstDate: firstDate,
              lastDate: lastDate,
            );

            if (pickedDate != null) {
              controller.text = DateFormat('MM/dd/yyyy').format(pickedDate);

              if (onDateChanged != null) {
                onDateChanged!(pickedDate);
              }
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "mm/dd/yyyy",
                filled: true,
                fillColor: themeData.colorScheme.secondary,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: themeData.colorScheme.secondary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: themeData.colorScheme.secondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: themeData.colorScheme.secondary, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: themeData.colorScheme.onError, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: themeData.colorScheme.onError, width: 2),
                ),
              ),
              validator: validator,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
