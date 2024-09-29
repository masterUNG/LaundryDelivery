import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:testdb/models/message_model.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/type_cloths_model.dart';
import 'package:testdb/models/type_detergen_model.dart';
import 'package:testdb/models/type_softener_model.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/admin_page.dart';
import 'package:testdb/screens/main_home.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  int calculateGrandTotal({required List<TypeClothsModel> typeClothsModels}) {
    int total = 0;

    for (var element in typeClothsModels) {
      total = total + (element.amount! * int.parse(element.price));
    }

    return total;
  }

  Future<TypeDetergenModel?> findDetenerFromString({required String id}) async {
    TypeDetergenModel? typeDetergenModel;

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getDetergenWhereId.php?isAdd=true&id=$id';

    var result = await Dio().get(urlAPI);

    for (var element in json.decode(result.data)) {
      typeDetergenModel = TypeDetergenModel.fromMap(element);
    }

    return typeDetergenModel;
  }

  Future<TypeSoftenerModel?> findSoftenerFromString(
      {required String id}) async {
    TypeSoftenerModel? typeSoftenerModel;

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getSoftenerWhereId.php?isAdd=true&id=$id';

    var result = await Dio().get(urlAPI);

    for (var element in json.decode(result.data)) {
      typeSoftenerModel = TypeSoftenerModel.fromMap(element);
    }

    return typeSoftenerModel;
  }

  Future<List<TypeClothsModel>> readAllTypeCloths() async {
    var typeClothsModels = <TypeClothsModel>[];

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getAllTypeCloths.php';

    var result = await Dio().get(urlAPI);

    for (var element in json.decode(result.data)) {
      TypeClothsModel model = TypeClothsModel.fromMap(element);
      typeClothsModels.add(model);
    }

    return typeClothsModels;
  }

  Future<List<TypeClothsModel>> readAllTypeClothsFromAmountCloth(
      {required String amountCloth}) async {
    String string = amountCloth.substring(1, amountCloth.length - 1);
    var strings = string.split(',');

    var amounts = <int>[];

    for (var element in strings) {
      amounts.add(int.parse(element.trim()));
    }

    var typeClothsModels = <TypeClothsModel>[];

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getAllTypeCloths.php';

    var result = await Dio().get(urlAPI);

    int index = 0;

    for (var element in json.decode(result.data)) {
      TypeClothsModel model = TypeClothsModel.fromMap(element);

      Map<String, dynamic> map = model.toMap();

      map['amount'] = amounts[index];

      typeClothsModels.add(TypeClothsModel.fromMap(map));

      if (index < amounts.length - 1) {
        index++;
      }
    }

    return typeClothsModels;
  }

  Future<List<TypeDetergenModel>> readAllTypeDetergen() async {
    var typeDetergenModels = <TypeDetergenModel>[];

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getAllTypeDetergen.php';

    var result = await Dio().get(urlAPI);

    for (var element in json.decode(result.data)) {
      TypeDetergenModel model = TypeDetergenModel.fromMap(element);
      typeDetergenModels.add(model);
    }

    return typeDetergenModels;
  }

  Future<List<TypeSoftenerModel>> readAllTypeSoftener() async {
    var typeSoftenerModels = <TypeSoftenerModel>[];

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getAllTypeSoftener.php';

    var result = await Dio().get(urlAPI);

    for (var element in json.decode(result.data)) {
      TypeSoftenerModel model = TypeSoftenerModel.fromMap(element);
      typeSoftenerModels.add(model);
    }

    return typeSoftenerModels;
  }

  Future<void> processReadAllMessageCustomer() async {
    if (appController.customerChatUserModels.isNotEmpty) {
      appController.customerChatUserModels.clear();
    }

    var result = await FirebaseFirestore.instance.collection('customer').get();

    if (result.docs.isNotEmpty) {
      for (var element in result.docs) {
        UserModel model = UserModel.fromMap(element.data());
        appController.customerChatUserModels.add(model);
      }
    }
  }

  Future<void> readAllMessageWhereCustomerIdUser(
      {required String customerIdUser}) async {
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(customerIdUser)
        .collection('message')
        .orderBy('timestamp')
        .snapshots()
        .listen((event) {
      if (appController.messageModels.isNotEmpty) {
        appController.messageModels.clear();
      }

      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          MessageModel model = MessageModel.fromMap(element.data());
          appController.messageModels.add(model);
        }
      }
    });
  }

  Future<void> processCheckHaveCustomer() async {
    var result = await FirebaseFirestore.instance
        .collection('customer')
        .doc(appController.currentUserModels.last.customerId)
        .get();

    if (result.data() == null) {
      await FirebaseFirestore.instance
          .collection('customer')
          .doc(appController.currentUserModels.last.customerId)
          .set(appController.currentUserModels.last.toMap());
    }
  }

  Future<void> processSendMessage(
      {required MessageModel messageModel, String? customerId}) async {
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(customerId ?? messageModel.customerId)
        .collection('message')
        .doc()
        .set(messageModel.toMap());
  }

  int calculateTotal({required List<OrderWashModel> orderWashModels}) {
    int total = 0;

    for (var element in orderWashModels) {
      total = total + int.parse(element.total.trim());
    }

    return total;
  }

  Future<List<OrderWashModel>> processReadOrderWhereStatus(
      {required String status}) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getOrderWhereStatus.php?isAdd=true&status=$status';

    var orderWashModels = <OrderWashModel>[];

    var result = await Dio().get(urlAPI);

    if (result.toString() != 'null') {
      for (var element in json.decode(result.data)) {
        OrderWashModel model = OrderWashModel.fromMap(element);
        orderWashModels.add(model);
      }
    }

    return orderWashModels;
  }

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

  Future<UserModel?> findUserModelId({required String id}) async {
    UserModel? userModel;

    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getUserWhereId.php?isAdd=true&id=$id';

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

              if (model.status == 'officer') {
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
    String? status,
  }) async {
    String urlApiCheckEmail =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getEmailWhereEmail.php?isAdd=true&email=$email';

    var resultCheckEmail = await Dio().get(urlApiCheckEmail);

    if (resultCheckEmail.toString() == 'null') {
      // email ไม่ซ้ำ

      String customerId = 'cus-${Random().nextInt(1000)}';

      String myStatus = status ?? 'user';

      String urlApiRegister =
          'https://www.androidthai.in.th/fluttertraining/UngFew/insertUser.php?isAdd=true&customerId=$customerId&address=$address&customerName=$name&lastName=$surName&phoneNumber=$phoneNumber&lat=$lat&lng=$lng&email=$email&password=$password&status=$myStatus';

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

  Future<List<UserModel>> processReadUserWhereStatus(
      {required String status}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/UngFew/getUserWhereStatus.php?isAdd=true&status=$status';

    var userModels = <UserModel>[];

    var result = await Dio().get(urlApi);

    if (result.toString() != 'null') {
      for (var element in json.decode(result.data)) {
        UserModel model = UserModel.fromMap(element);
        userModels.add(model);
      }
    }

    return userModels;
  }
}
