import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/main_home.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processCheckLogin({
    required String email,
    required String password,
  }) async {
    String urlApiCheckLogin =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getEmailWhereEmail.php?isAdd=true&email=$email';

    await Dio().get(urlApiCheckLogin).then(
      (value) {
        if (value.toString() == 'null') {
          Get.snackbar('Email False', 'ไม่มี $email ในฐานข้อมูล',
              backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
        } else {
          for (var element in json.decode(value.data)) {
            UserModel model = UserModel.fromMap(element);

            if (model.password == password) {
              // password true

              Get.offAll(const MainHome());
            } else {
              Get.snackbar('Password False', 'Please Try Again Password False',
                  backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
            }
          }
        }
      },
    );
  }

  Future<void> processRegister({
    required String name,
    required String surName,
    required String phoneNumber,
    required String address,
    required String email,
    required String password,
    required String lat,
    required String lng,
  }) async {
    String urlApiCheckEmail =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getEmailWhereEmail.php?isAdd=true&email=$email';

    var resultCheckEmail = await Dio().get(urlApiCheckEmail);

    if (resultCheckEmail.toString() == 'null') {
      // email ไม่ซ้ำ

      String customerId = 'cus-${Random().nextInt(1000)}';

      String urlApiRegister =
          'https://www.androidthai.in.th/fluttertraining/UngFew/insertUser.php?isAdd=true&customerId=$customerId&address=$address&customerName=$name&lastName=$surName&phoneNumber=$phoneNumber&lat=$lat&lng=$lng&email=$email&password=$password';

      await Dio().get(urlApiRegister).then(
        (value) {
          Get.back();
          Get.snackbar('Register Success', 'Welcome To My App Please Login');
        },
      );
    } else {
      Get.snackbar(
        'Email ซ้ำ',
        'มี $email นี่ในฐานข้อมูล แล้ว กรุณาเปลียน email ใหม่',
        backgroundColor: GFColors.DANGER,
        colorText: GFColors.WHITE,
      );
    }
  }

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
