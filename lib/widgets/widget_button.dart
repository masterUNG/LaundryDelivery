// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.type,
    this.textStyle,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final GFButtonType? type;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      type: type ?? GFButtonType.solid,
      textStyle: textStyle,
    );
  }
}
