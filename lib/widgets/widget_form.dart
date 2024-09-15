// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.controller,
    this.validator,
    this.labelText,
    this.onChanged,
    this.hintText,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Function(String)? onChanged;
  final String? hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(obscureText: obscureText ?? false,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        border: InputBorder.none,
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
