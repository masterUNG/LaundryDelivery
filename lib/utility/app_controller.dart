import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxList positions = <Position>[].obs;

  RxInt indexBody = 0.obs;

  RxList<DateTime> chooseStartWorkDateTimes = <DateTime>[].obs;

  RxList<DateTime?> chooseStartWorkHHmm = <DateTime?>[null].obs;

  RxList<DateTime> chooseEndWorkDateTimes = <DateTime>[].obs;
  RxList<DateTime?> chooseEndWorkHHmm = <DateTime?>[null].obs;

  RxBool optionWashClothes = false.obs;
  RxBool optionDryClothes = false.obs;

  RxList<int?> chooseAmountCloths = <int?>[null].obs;
  RxList<int?> chooseAmountDetergent = <int?>[null].obs;
  RxList<int?> chooseAmountSofterner = <int?>[null].obs;

  RxInt total = 0.obs;
}
