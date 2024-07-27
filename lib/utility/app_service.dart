import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processFindPosition() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();

    print('locationService ---> $locationService');

    if (locationService) {
      //Open Service

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //DeniedForever
        dialogCallPermissionLocation();
      } else {
        //Away, WhileInUser, Denied

        if (locationPermission == LocationPermission.denied) {
          //Denied

          locationPermission = await Geolocator.requestPermission();

          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            dialogCallPermissionLocation();
          } else {
            Position position = await Geolocator.getCurrentPosition();
            appController.positions.add(position);
          }
        } else {
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      //Off Service
      AppDialog().normalDialog(
          title: 'โปรดเปิด Location Service',
          secondAction: WidgetButton(
              onPressed: () async {
                await Geolocator.openLocationSettings()
                    .then((value) => exit(0));
              },
              text: 'ไปเปิด Location Service'));
    }
  }

  void dialogCallPermissionLocation() {
    AppDialog().normalDialog(
        title: 'โปรดอนุญาติแชร์พิกัด',
        secondAction: WidgetButton(
            onPressed: () async {
              await Geolocator.openAppSettings().then(
                (value) => exit(0),
              );
            },
            text: 'โปรดอนุญาติแชร์พิกัด'));
  }
}
