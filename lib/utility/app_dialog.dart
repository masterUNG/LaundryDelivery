import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppDialog {
  void normalDialog({
    required String title,
    Widget? firstAction,
    Widget? secondAction,
    Widget? contentWidget,
    Widget? iconWidget,
  }) {
    Get.dialog(
        AlertDialog(
          icon: iconWidget,
          content: contentWidget,
          title: Text(title),
          actions: [
            firstAction ?? const SizedBox(),
            secondAction ??
                WidgetButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: firstAction == null ? 'OK' : 'Cancel')
          ],
        ),
        barrierDismissible: false);
  }
}
