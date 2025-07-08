import 'package:flutter/material.dart';

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
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            DateTime now = DateTime.now();
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate ?? now,
              firstDate: firstDate,
              lastDate: lastDate,
            );

            if (pickedDate != null) {
              controller.text =
                  "${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.year}";

              if (onDateChanged != null) {
                onDateChanged!(pickedDate);
              }
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "MM/DD/YYYY",
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
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
