import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/utility/app_constant.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class ChooseProduct extends StatefulWidget {
  const ChooseProduct({super.key});

  @override
  State<ChooseProduct> createState() => _ChooseProductState();
}

class _ChooseProductState extends State<ChooseProduct> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Wash'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              displayStartWork(context),
              displayEndWork(context),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/wash2.png',
                    width: 100,
                  ),
                  const Text('เครื่องซีกผ้า 40 บาท'),
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/wash1.png',
                    width: 100,
                  ),
                  const Text('เครื่องอบผ้า 40 บาท'),
                  Obx(() => Checkbox(
                        value: appController.optionDryClothes.value,
                        onChanged: (value) {
                          appController.optionDryClothes.value =
                              !appController.optionDryClothes.value;
                        },
                      ))
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('จำนวนเสื้อผ่า ชิ้นละ 5 บาท'),
              SizedBox(
                width: 100,
                child: Obx(() => DropdownButton(
                      hint: const Text('จำนวน'),
                      value: appController.chooseAmountCloths.last,
                      items: AppConstant.amountCloths
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        appController.chooseAmountCloths.add(value);
                      },
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('น้ำยาซักผ้า 10 บาท'),
              SizedBox(
                width: 100,
                child: Obx(() => DropdownButton(
                      hint: const Text('จำนวน'),
                      value: appController.chooseAmountDetergent.last,
                      items: AppConstant.amountOption
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        appController.chooseAmountDetergent.add(value);
                      },
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('น้ำยาปรับผ้านุ่ม 10 บาท'),
              SizedBox(
                width: 100,
                child: Obx(() => DropdownButton(
                      hint: const Text('จำนวน'),
                      value: appController.chooseAmountSofterner.last,
                      items: AppConstant.amountOption
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        appController.chooseAmountSofterner.add(value);
                      },
                    )),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'รวมราคา :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Obx(() => Text(
                    '${(appController.optionWashClothes.value ? 40 : 0) + (appController.optionDryClothes.value ? 40 : 0) + (appController.chooseAmountCloths.last != null ? 5 * appController.chooseAmountCloths.last! : 0) + (appController.chooseAmountDetergent.last != null ? 10 * appController.chooseAmountDetergent.last! : 0) + (appController.chooseAmountSofterner.last != null ? 10 * appController.chooseAmountSofterner.last! : 0)} บาท',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
      floatingActionButton: WidgetButton(
          onPressed: () async {
            if ((appController.chooseStartWorkDateTimes.isEmpty) ||
                (appController.chooseStartWorkHHmm.last == null)) {
              Get.snackbar('เวลารับผ้า', 'กรุณาเลือกเวลารับผ้า');
            } else if ((appController.chooseEndWorkDateTimes.isEmpty) ||
                (appController.chooseEndWorkHHmm.last == null)) {
              Get.snackbar('เวลาส่งผ้า', 'กรุณาเลือกเวลาส่งผ้า');
            } else if (appController.chooseAmountCloths.last == null) {
              Get.snackbar('จำนวนเสื้อผ้า', 'กรุณาเลือกจำนวน เสื้อผ้าด้วย คะ');
            } else if (appController.chooseAmountDetergent.last == null) {
              Get.snackbar('น้ำยาซักผ้า', 'กรุณาเลือกน้ำยาซักผ้าด้วย คะ');
            } else if (appController.chooseAmountSofterner.last == null) {
              Get.snackbar(
                  'น้ำยาปรับผ้านุ่ม', 'กรุณาเลือกน้ำยาปรับผ้านุ่มด้วย คะ');
            } else {
              OrderWashModel model = OrderWashModel(
                  id: '',
                  refWash: 'ref-${Random().nextInt(10000)}',
                  customerId: appController.currentUserModels.last.customerId,
                  dateStart: AppService().changeDateTimeToString(
                      dateTime: appController.chooseStartWorkDateTimes.last),
                  timeStar: AppService().changeDateTimeToString(
                      dateTime: appController.chooseStartWorkHHmm.last!,
                      timeFormat: 'HH:mm'),
                  dateEnd: AppService().changeDateTimeToString(
                      dateTime: appController.chooseEndWorkDateTimes.last),
                  timeEnd: AppService().changeDateTimeToString(
                      dateTime: appController.chooseEndWorkHHmm.last!,
                      timeFormat: 'HH:mm'),
                  dry: appController.optionDryClothes.value.toString(),
                  amountCloth: appController.chooseAmountCloths.last.toString(),
                  detergen: appController.chooseAmountDetergent.last.toString(),
                  softener: appController.chooseAmountSofterner.last.toString(),
                  total:
                      '${(appController.optionWashClothes.value ? 40 : 0) + (appController.optionDryClothes.value ? 40 : 0) + (appController.chooseAmountCloths.last != null ? 5 * appController.chooseAmountCloths.last! : 0) + (appController.chooseAmountDetergent.last != null ? 10 * appController.chooseAmountDetergent.last! : 0) + (appController.chooseAmountSofterner.last != null ? 10 * appController.chooseAmountSofterner.last! : 0)}',
                  status: 'Order');

              print('## model ---> ${model.toMap()}');

              await AppService().processInsertOrder(orderWashModel: model);
            }
          },
          text: 'Order'),
    );
  }

  InkWell displayEndWork(BuildContext context) {
    return InkWell(
      onTap: () async {
        var endWorkDateTime = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)));

        if (endWorkDateTime != null) {
          appController.chooseEndWorkDateTimes.add(endWorkDateTime);

          final keyForm = GlobalKey<FormState>();

          AppDialog().normalDialog(
              title: 'เลือกเวลา',
              contentWidget: Form(
                key: keyForm,
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'กรุณาเลือกเวลาด้วย คะ';
                    } else {
                      return null;
                    }
                  },
                  hint: const Text('โปรดเลือกช่วงเวลา'),
                  value: appController.chooseEndWorkHHmm.last,
                  items: AppConstant.dateTimes
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(AppService().changeDateTimeToString(
                              dateTime: e, timeFormat: 'HH:mm')),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    appController.chooseEndWorkHHmm.add(value!);
                  },
                ),
              ),
              secondAction: WidgetButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      Get.back();
                    }
                  },
                  text: 'OK'));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('เวลาส่งผ้า'),
            Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appController.chooseEndWorkDateTimes.isEmpty
                        ? 'dd / MM / yy'
                        : AppService().changeDateTimeToString(
                            dateTime:
                                appController.chooseEndWorkDateTimes.last)),
                    const SizedBox(width: 8),
                    Text(appController.chooseEndWorkHHmm.last == null
                        ? 'HH:mm'
                        : AppService().changeDateTimeToString(
                            dateTime: appController.chooseEndWorkHHmm.last!,
                            timeFormat: 'HH:mm')),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  InkWell displayStartWork(BuildContext context) {
    return InkWell(
      onTap: () async {
        var startWorkDateTime = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)));

        if (startWorkDateTime != null) {
          appController.chooseStartWorkDateTimes.add(startWorkDateTime);

          final keyForm = GlobalKey<FormState>();

          AppDialog().normalDialog(
              title: 'เลือกเวลา',
              contentWidget: Form(
                key: keyForm,
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'กรุณาเลือกเวลาด้วย คะ';
                    } else {
                      return null;
                    }
                  },
                  hint: const Text('โปรดเลือกช่วงเวลา'),
                  value: appController.chooseStartWorkHHmm.last,
                  items: AppConstant.dateTimes
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(AppService().changeDateTimeToString(
                              dateTime: e, timeFormat: 'HH:mm')),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    appController.chooseStartWorkHHmm.add(value!);
                  },
                ),
              ),
              secondAction: WidgetButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      Get.back();
                    }
                  },
                  text: 'OK'));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('เวลารับผ้า'),
            Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appController.chooseStartWorkDateTimes.isEmpty
                        ? 'dd / MM / yy'
                        : AppService().changeDateTimeToString(
                            dateTime:
                                appController.chooseStartWorkDateTimes.last)),
                    const SizedBox(width: 8),
                    Text(appController.chooseStartWorkHHmm.last == null
                        ? 'HH:mm'
                        : AppService().changeDateTimeToString(
                            dateTime: appController.chooseStartWorkHHmm.last!,
                            timeFormat: 'HH:mm')),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
