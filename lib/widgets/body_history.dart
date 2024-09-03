import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/utility/app_take_photo.dart';
import 'package:testdb/widgets/widget_button.dart';

class BodyHistory extends StatefulWidget {
  const BodyHistory({super.key});

  @override
  State<BodyHistory> createState() => _BodyHistoryState();
}

class _BodyHistoryState extends State<BodyHistory> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    print('history Work');

    if (appController.currentUserModels.isEmpty) {
      AppService().findCurrentUserLogin().then(
        (value) {
          AppService().readAllOrder();
        },
      );
    } else {
      AppService().readAllOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.orderWashModels.isEmpty
        ? const SizedBox()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: appController.orderWashModels.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                AppDialog().normalDialog(
                  title: appController.orderWashModels[index].refWash,
                  contentWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'วันรับผ้า : ${appController.orderWashModels[index].dateStart}'),
                      Text(
                          'เวลารับผ้า : ${appController.orderWashModels[index].timeStar}'),
                      const Divider(),
                      Text(
                          'วันส่งผ้า : ${appController.orderWashModels[index].dateEnd}'),
                      Text(
                          'เวลาส่งผ้า : ${appController.orderWashModels[index].timeEnd}'),
                      const Divider(),
                      CheckboxListTile(
                        value: bool.parse(
                            appController.orderWashModels[index].dry),
                        title: const Text('เครื่องอบผ้า'),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {},
                      ),
                      const Divider(),
                      Text(
                          'จำนวนเสื่อผ้า : ${appController.orderWashModels[index].amountCloth} ชิ้น'),
                      Text(
                          'ผงซักฝอก : ${appController.orderWashModels[index].detergen}'),
                      Text(
                          'น้ำยาปรับผ้่านุ้ม : ${appController.orderWashModels[index].softener}'),
                      const Divider(),
                      Text(
                        'ค่าใช้จ่ายทั้งหมด : ${appController.orderWashModels[index].total} บาท',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      appController.orderWashModels[index].status == 'Order'
                          ? const Text('รอรับผ้าก่อน แล้ว จะได้ QR พร้อมเพล์',
                              style: TextStyle(
                                  fontSize: 10, color: GFColors.DANGER))
                          : appController.orderWashModels[index].status ==
                                  'Receive'
                              ? Image.network(
                                  'https://promptpay.io/0818595309/${appController.orderWashModels[index].total}')
                              : Image.network(appController.orderWashModels[index].urlSlip),
                    ],
                  ),
                  firstAction: appController.orderWashModels[index].status ==
                          'Order'
                      ? null
                      : appController.orderWashModels[index].status == 'Receive' ? WidgetButton(
                          onPressed: () async {
                            String url =
                                'https://promptpay.io/0818595309/${appController.orderWashModels[index].total}';

                            var response = await Dio().get(url,
                                options:
                                    Options(responseType: ResponseType.bytes));

                            final result = await ImageGallerySaver.saveImage(
                                Uint8List.fromList(response.data),
                                quality: 60,
                                name: 'promptpay');

                            if (result['isSuccess']) {
                              Get.back();
                              Get.snackbar('โหลด QRcode สำเร็จ',
                                  'เปิดแอพ ธนาคาร และ Scan QR code ผ่านไฟร์ และ กลับมา อัพโหลดสลิป');
                            }
                          },
                          text: 'โหลด QRcode เก็บในเครื่อง',
                          type: GFButtonType.outline2x,
                        ) : null,
                  thirdAction:
                      appController.orderWashModels[index].status == 'Order'
                          ? null
                          : appController.orderWashModels[index].status == 'Receive' ? WidgetButton(
                              onPressed: () async {
                                await AppTakePhoto().uploadImage().then(
                                  (value) async {
                                    String urlSlip = value;
                                    print('##3sep urlSlip ---> $urlSlip');

                                    String urlEditUrlSlip =
                                        'https://www.androidthai.in.th/fluttertraining/UngFew/editUrlSlipWhereId.php?isAdd=true&id=${appController.orderWashModels[index].id}&status=Payment&urlSlip=$urlSlip';

                                    await Dio().get(urlEditUrlSlip).then(
                                      (value) {
                                        Get.back();
                                        AppService().readAllOrder();
                                      },
                                    );
                                  },
                                );
                              },
                              text: 'อัพโหลด สลิป',
                              type: GFButtonType.outline2x,
                            ) : null,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(appController.orderWashModels[index].refWash),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color:
                                  appController.orderWashModels[index].status ==
                                          'Order'
                                      ? Colors.green
                                      : appController.orderWashModels[index]
                                                  .status ==
                                              'Receive'
                                          ? Colors.orange
                                          : Colors.pink.shade200),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                              'Status : ${appController.orderWashModels[index].status}'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'รับผ้า : ${appController.orderWashModels[index].dateStart}'),
                        Text(
                            'ส่งผ้า : ${appController.orderWashModels[index].dateEnd}'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
  }
}
