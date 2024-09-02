import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/admin_page.dart';
import 'package:testdb/screens/main_home.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processEditStatusByIdOrder({
    required String id,
    required String status,
    String? idAdminReceive,
    String? idAdminOrder,
  }) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/editStatusWhereId.php?isAdd=true&id=$id&status=$status&idAdminReceive=$idAdminReceive&idAdminOrder=$idAdminOrder';

    await Dio().get(urlAPI).then(
      (value) {
        Get.back();
      },
    );
  }

  Future<UserModel?> findUserModelFromCustomerId(
      {required String customerId}) async {
    UserModel? userModel;

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getUserWhereCustomerId.php?isAdd=true&customerId=$customerId';

    var result = await Dio().get(urlAPI);

    for (var element in json.decode(result.data)) {
      userModel = UserModel.fromMap(element);
    }

    return userModel;
  }

  Future<void> readAllOrder() async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getAllOrder.php';

    var result = await Dio().get(urlApi);

    if (appController.orderWashModels.isNotEmpty) {
      appController.orderWashModels.clear();
    }

    for (var element in json.decode(result.data)) {
      OrderWashModel model = OrderWashModel.fromMap(element);
      if (model.customerId == appController.currentUserModels.last.customerId) {
        appController.orderWashModels.add(model);
      }
    }
  }

  Future<void> readAllOrderForAdmin() async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getAllOrder.php';

    var result = await Dio().get(urlApi);

    if (appController.orderWashModels.isNotEmpty) {
      appController.orderWashModels.clear();
    }

    for (var element in json.decode(result.data)) {
      OrderWashModel model = OrderWashModel.fromMap(element);

      appController.orderWashModels.add(model);
    }
  }

  Future<void> processInsertOrder(
      {required OrderWashModel orderWashModel}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/UngFew/insertOrder.php?isAdd=true&refWash=${orderWashModel.refWash}&customerId=${orderWashModel.customerId}&dateStart=${orderWashModel.dateStart}&timeStar=${orderWashModel.timeStar}&dateEnd=${orderWashModel.dateEnd}&timeEnd=${orderWashModel.timeEnd}&dry=${orderWashModel.dry}&amountCloth=${orderWashModel.amountCloth}&detergen=${orderWashModel.detergen}&softener=${orderWashModel.softener}&total=${orderWashModel.total}&status=${orderWashModel.status}';

    await Dio().get(urlApi).then(
      (value) async {
        await Get.deleteAll().then(
          (value) {
            findCurrentUserLogin();
            Get.back();
            Get.snackbar('Order Success', 'ThangYou Order Success');
          },
        );
      },
    );
  }

  Future<void> findCurrentUserLogin() async {
    var result = await GetStorage().read('data');

    if (result != null) {
      String urlAPI =
          'https://www.androidthai.in.th/fluttertraining/UngFew/getEmailWhereEmail.php?isAdd=true&email=${result["email"]}';

      var response = await Dio().get(urlAPI);

      for (var element in json.decode(response.data)) {
        UserModel model = UserModel.fromMap(element);
        appController.currentUserModels.add(model);
      }
    }
  }

  String changeDateTimeToString(
      {required DateTime dateTime, String? timeFormat}) {
    DateFormat dateFormat = DateFormat(timeFormat ?? 'dd / MMM / yy');

    String result = dateFormat.format(dateTime);

    return result;
  }

  Future<void> processCheckLogin({
    required String email,
    required String password,
  }) async {
    String urlApiCheckLogin =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getEmailWhereEmail.php?isAdd=true&email=$email';

    await Dio().get(urlApiCheckLogin).then(
      (value) async {
        if (value.toString() == 'null') {
          Get.snackbar('Email False', 'ไม่มี $email ในฐานข้อมูล',
              backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
        } else {
          for (var element in json.decode(value.data)) {
            UserModel model = UserModel.fromMap(element);

            if (model.password == password) {
              // password true

              if ((model.email == 'admin1@abc.com') ||
                  (model.email == 'admin2@abc.com') ||
                  (model.email == 'admin3@abc.com')) {
                //Admin Login

                Get.offAll(AdminPage(userModel: model));
              } else {
                await GetStorage().write('data', model.toMap()).then(
                  (value) {
                    Get.offAll(const MainHome());
                  },
                );
              }
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
