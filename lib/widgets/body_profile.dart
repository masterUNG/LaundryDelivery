// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_form.dart';
import 'package:testdb/widgets/widget_icon_button.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    if (appController.currentUserModels.isEmpty) {
      AppService().findCurrentUserLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.currentUserModels.isEmpty
        ? const SizedBox()
        : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Text(
                  'CustomerId : ${appController.currentUserModels.last.customerId}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'CustomerName : ${appController.currentUserModels.last.customerName}'),
                  WidgetIconButton(
                    iconData: Icons.edit_outlined,
                    onPressed: () {
                      TextEditingController textEditingController =
                          TextEditingController();
                      textEditingController.text =
                          appController.currentUserModels.last.customerName;

                      bool change = false;

                      AppDialog().normalDialog(
                          title: 'แก้ไข CustomerName',
                          contentWidget: WidgetForm(
                              onChanged: (p0) {
                                change = true;
                              },
                              labelText: 'CustomerName',
                              controller: textEditingController),
                          firstAction: WidgetButton(
                              onPressed: () async {
                                if (change) {
                                  String urlAPI =
                                      'https://www.androidthai.in.th/fluttertraining/UngFew/editCustomerNameWhereId.php?isAdd=true&id=${appController.currentUserModels.last.id}&customerName=${textEditingController.text}';
                                  print('## urlAPI ----> $urlAPI');

                                  await Dio().get(urlAPI).then(
                                    (value) {
                                      AppService().findCurrentUserLogin();
                                      Get.back();
                                    },
                                  );
                                }
                              },
                              text: 'บันทึก',
                              type: GFButtonType.outline2x));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'LastName : ${appController.currentUserModels.last.lastName}'),


                  WidgetIconButton(
                    iconData: Icons.edit_outlined,
                    onPressed: () {
                      TextEditingController textEditingController =
                          TextEditingController();
                      textEditingController.text =
                          appController.currentUserModels.last.lastName;

                      bool change = false;

                      AppDialog().normalDialog(
                          title: 'แก้ไข LastName',
                          contentWidget: WidgetForm(
                              onChanged: (p0) {
                                change = true;
                              },
                              labelText: 'LastName',
                              controller: textEditingController),
                          firstAction: WidgetButton(
                              onPressed: () async {
                                if (change) {
                                  String urlAPI =
                                      'https://www.androidthai.in.th/fluttertraining/UngFew/editLastNameWhereId.php?isAdd=true&id=${appController.currentUserModels.last.id}&lastName=${textEditingController.text}';

                                  await Dio().get(urlAPI).then(
                                    (value) {
                                      AppService().findCurrentUserLogin();
                                      Get.back();
                                    },
                                  );
                                }
                              },
                              text: 'บันทึก',
                              type: GFButtonType.outline2x));
                    },
                  ),


                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Address : ${appController.currentUserModels.last.address}'),

                   WidgetIconButton(
                    iconData: Icons.edit_outlined,
                    onPressed: () {
                      TextEditingController textEditingController =
                          TextEditingController();
                      textEditingController.text =
                          appController.currentUserModels.last.address;

                      bool change = false;

                      AppDialog().normalDialog(
                          title: 'แก้ไข Address',
                          contentWidget: WidgetForm(
                              onChanged: (p0) {
                                change = true;
                              },
                              labelText: 'Address',
                              controller: textEditingController),
                          firstAction: WidgetButton(
                              onPressed: () async {
                                if (change) {
                                  String urlAPI =
                                      'https://www.androidthai.in.th/fluttertraining/UngFew/editAddressWhereId.php?isAdd=true&id=${appController.currentUserModels.last.id}&address=${textEditingController.text}';

                                  await Dio().get(urlAPI).then(
                                    (value) {
                                      AppService().findCurrentUserLogin();
                                      Get.back();
                                    },
                                  );
                                }
                              },
                              text: 'บันทึก',
                              type: GFButtonType.outline2x));
                    },
                  ),



                ],
              ),
            ],
          ));
  }
}
