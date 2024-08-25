import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';

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
        : ListView(padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text('CustomerId : ${appController.currentUserModels.last.customerId}'),
            Text('CustomerName : ${appController.currentUserModels.last.customerName}'),
            Text('LastName : ${appController.currentUserModels.last.lastName}'),
            Text('Address : ${appController.currentUserModels.last.address}'),
          ],
        ));
  }
}
