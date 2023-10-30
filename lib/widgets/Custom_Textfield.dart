import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final int? maxLength;
  final int? maxlines;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labeltext,
      required this.maxlines,
      required this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxlines,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        labelText: labeltext,
        prefixIcon: const Icon(Icons.note),
      ),
    );
  }
}
