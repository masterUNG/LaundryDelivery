import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      type: GFButtonType.transparent,
    );
  }
}
