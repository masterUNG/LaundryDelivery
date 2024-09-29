import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/utility/app_constant.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_form.dart';

class ChooseProduct extends StatefulWidget {
  const ChooseProduct({super.key});

  @override
  State<ChooseProduct> createState() => _ChooseProductState();
}

class _ChooseProductState extends State<ChooseProduct> {
  AppController appController = Get.put(AppController());

  var textControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();

    appController.changeTextField.value = false;

    if (appController.currentUserModels.isEmpty) {
      AppService().findCurrentUserLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Wash'),
        actions: [orderButton()],
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
          aboutCloths(),
          const SizedBox(height: 16),
          aboutDetergen(),
          const SizedBox(height: 16),
          aboutSoftener(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text('น้ำยาปรับผ้านุ่ม 10 บาท'),
          //     SizedBox(
          //       width: 100,
          //       child: Obx(() => DropdownButton(
          //             hint: const Text('จำนวน'),
          //             value: appController.chooseAmountSofterner.last,
          //             items: AppConstant.amountOption
          //                 .map(
          //                   (e) => DropdownMenuItem(
          //                     child: Text(e.toString()),
          //                     value: e,
          //                   ),
          //                 )
          //                 .toList(),
          //             onChanged: (value) {
          //               appController.chooseAmountSofterner.add(value);
          //             },
          //           )),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 32),
          // displayTotalPrice()
        ],
      ),
      // floatingActionButton: orderButton(),
    );
  }

  Row displayTotalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'รวมราคา :',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Obx(() => Text(
              '${(appController.optionWashClothes.value ? 40 : 0) + (appController.optionDryClothes.value ? 40 : 0) + (appController.chooseAmountCloths.last != null ? 5 * appController.chooseAmountCloths.last! : 0) + (appController.chooseAmountDetergent.last != null ? 10 * appController.chooseAmountDetergent.last! : 0) + (appController.chooseAmountSofterner.last != null ? 10 * appController.chooseAmountSofterner.last! : 0)} บาท',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget orderButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: WidgetButton(
          onPressed: () async {
            if ((appController.chooseStartWorkDateTimes.isEmpty) ||
                (appController.chooseStartWorkHHmm.last == null)) {
              Get.snackbar('เวลารับผ้า', 'กรุณาเลือกเวลารับผ้า');
            } else if ((appController.chooseEndWorkDateTimes.isEmpty) ||
                (appController.chooseEndWorkHHmm.last == null)) {
              Get.snackbar('เวลาส่งผ้า', 'กรุณาเลือกเวลาส่งผ้า');
            } else if (!appController.changeTextField.value) {
              Get.snackbar('ยังไม่ได้เลือกจำนวน', 'กรุณาเลือกจำนวนด้วย');
            } else if (appController.chooseTypeDetergenModels.last == null) {
              Get.snackbar('ย้งไม่ได้เลือกนำ้ยาซักผ้า', 'โปรดเลือกนำ้ยาซักผ้า');
            } else if (appController.chooseTypeSoftenerModels.last == null) {
              Get.snackbar('ยังไม่ได้เลือกน้ำยาปรับผ้านุ้ม',
                  'โปรดเลือกน้ำยาปรับผ้านุ้ม');
            } else {
              var amountCloth = <String>[];

              int total = 0;

              for (var i = 0; i < textControllers.length; i++) {
                if (textControllers[i].text.isEmpty) {
                  amountCloth.add('0');
                } else {
                  amountCloth.add(textControllers[i].text);
                }
              }

              print('## amountCloth --> $amountCloth');

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
                  amountCloth: amountCloth.toString(),
                  detergen: appController.chooseTypeDetergenModels.last!.id,
                  softener: appController.chooseTypeSoftenerModels.last!.id,
                  total: '',   
                  status: 'Order',
                  idAdminReceive: '',
                  idAdminOrder: '',
                  urlSlip: '',
                  idAdminFinish: '');

              print('## model ---> ${model.toMap()}');

              await AppService().processInsertOrder(orderWashModel: model);
            }
          },
          text: 'Order'),
    );
  }

  Widget aboutDetergen() {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'เลือกน้ำยาซักผ้า',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: AppService().readAllTypeDetergen(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var typeDetergenModels = snapshot.data;

                return ListView.builder(
                  itemCount: typeDetergenModels!.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Obx(() => RadioListTile(
                          value: typeDetergenModels[index],
                          groupValue:
                              appController.chooseTypeDetergenModels.last,
                          onChanged: (value) {
                            appController.chooseTypeDetergenModels.add(value);
                          },
                          title: Text(typeDetergenModels[index].typeDetergen),
                          subtitle: Text(
                              'ราคา ${typeDetergenModels[index].price} บาท'),
                        ));
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget aboutSoftener() {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'เลือกน้ำยาปรับผ้านุ้ม',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: AppService().readAllTypeSoftener(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var typeSoftenerModels = snapshot.data;

                return ListView.builder(
                  itemCount: typeSoftenerModels!.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Obx(() => RadioListTile(
                          value: typeSoftenerModels[index],
                          groupValue:
                              appController.chooseTypeSoftenerModels.last,
                          onChanged: (value) {
                            appController.chooseTypeSoftenerModels.add(value);
                          },
                          title: Text(typeSoftenerModels[index].typeSoftener),
                          subtitle: Text(
                              'ราคา ${typeSoftenerModels[index].price} บาท'),
                        ));
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget aboutCloths() {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'เลือกจำนวน และ ชนิดเสื้อผ้า',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: AppService().readAllTypeCloths(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var typeClothsModels = snapshot.data!;

                for (var element in typeClothsModels) {
                  TextEditingController textEditingController =
                      TextEditingController();
                  textControllers.add(textEditingController);
                }

                return ListView.builder(
                  itemCount: typeClothsModels.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'จำนวน ${typeClothsModels[index].typeCloths} ชิ้นละ ${typeClothsModels[index].price} บาท'),
                          SizedBox(
                            width: 100,
                            child: WidgetForm(
                              controller: textControllers[index],
                              keyboardType: TextInputType.number,
                              onChanged: (p0) {
                                appController.changeTextField.value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
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
