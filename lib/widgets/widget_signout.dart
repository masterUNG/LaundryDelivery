
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/screens/login_page.dart';
import 'package:testdb/widgets/widget_button.dart';

class WidgetSignOut extends StatelessWidget {
  const WidgetSignOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: WidgetButton(
        onPressed: () {
          Get.offAll(LoginPage());
        },
        text: 'SignOut',
        color: GFColors.DANGER,
      ),
    );
  }
}
