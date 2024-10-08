// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({
    Key? key,
    required this.orderWashModel,
    this.adminUserModel,
  }) : super(key: key);

  final OrderWashModel orderWashModel;
  final UserModel? adminUserModel;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    appController.receive.value = false;

    if (widget.orderWashModel.status != 'Order') {
      appController.receive.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderWashModel.refWash),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          displayStartEnd(),
          const Divider(),
          displayDetail(),
          const Divider(),
          FutureBuilder(
            future: AppService().findUserModelFromCustomerId(
                customerId: widget.orderWashModel.customerId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel model = snapshot.data!;

                Set<Marker> customerMaker = <Marker>[
                  Marker(
                      markerId: MarkerId(model.id),
                      position: LatLng(
                          double.parse(model.lat), double.parse(model.lng)))
                ].toSet();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ข้อมูลผู้สั่ง :'),
                    Row(
                      children: [
                        Text(model.customerName),
                        const SizedBox(width: 16),
                        Text(model.lastName),
                      ],
                    ),
                    Text('ที่อยู่ : ${model.address}'),
                    ((widget.orderWashModel.status == 'Order') ||
                            (widget.orderWashModel.status == 'Receive') ||
                            (widget.orderWashModel.status == 'Payment'))
                        ? SizedBox(
                            width: Get.width,
                            height: Get.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(double.parse(model.lat),
                                      double.parse(model.lng)),
                                  zoom: 16),
                              markers: customerMaker,
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const Divider(),
          ((widget.orderWashModel.status == 'Payment') ||
                  (widget.orderWashModel.status == 'Finish'))
              ? Image.network(widget.orderWashModel.urlSlip)
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget displayDetail() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('จำนวนเลือผ้า : ${widget.orderWashModel.amountCloth} ชิ้น'),

            //List Order
            FutureBuilder(
              future: AppService().readAllTypeClothsFromAmountCloth(
                  amountCloth: widget.orderWashModel.amountCloth),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var typeClothsModels = snapshot.data;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Get.width - 32,
                        // height: ((20 * typeClothsModels!.length).toDouble()),
                        child: ListView.builder(
                          itemCount: typeClothsModels!.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return typeClothsModels[index].amount == 0
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${typeClothsModels[index].typeCloths} (ราคา ${typeClothsModels[index].price} บาท/ช้ิน)'),
                                      Text(typeClothsModels[index]
                                          .amount
                                          .toString()),
                                    ],
                                  );
                          },
                        ),
                      ),
                      Text(
                        'ค่าใช้จ่ายทั้งหมด : ${AppService().calculateGrandTotal(typeClothsModels: typeClothsModels)} บาท',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            FutureBuilder(
              future: AppService()
                  .findDetenerFromString(id: widget.orderWashModel.detergen),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var typeDetenerModel = snapshot.data;

                  return SizedBox(
                    width: Get.width - 32,
                    child: Text(
                        'ผงซักฝอก : ${typeDetenerModel!.typeDetergen} (ราคา ${typeDetenerModel.price} บาท)'),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            FutureBuilder(
              future: AppService()
                  .findSoftenerFromString(id: widget.orderWashModel.softener),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var typeSoftenerModel = snapshot.data;

                  return SizedBox(
                    width: Get.width - 32,
                    child: Text(
                        'น้ำยาปรับผ้่านุ้ม : ${typeSoftenerModel!.typeSoftener} (ราคา ${typeSoftenerModel.price} บาท)'),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            ((widget.adminUserModel != null) &&
                    ((widget.orderWashModel.status == 'Payment') ||
                        (widget.orderWashModel.status == 'Finish')))
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('ชำระค่าบริการแล้ว'),
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      widget.orderWashModel.status == 'Payment'
                          ? WidgetButton(
                              onPressed: () async {
                                String urlApi =
                                    'https://www.androidthai.in.th/fluttertraining/UngFew/editFinishWhereId.php?isAdd=true&id=${widget.orderWashModel.id}&idAdminFinish=${widget.adminUserModel!.id}';

                                await Dio().get(urlApi).then((value) {
                                  Get.back();
                                });
                              },
                              text: 'ส่งเสื้อผ้า',
                              type: GFButtonType.outline2x,
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin ทีี่ส่งผ้่า :'),
                                FutureBuilder(
                                  future: AppService().findUserModelId(
                                      id: widget.orderWashModel.idAdminFinish),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      UserModel? model = snapshot.data;

                                      if (model == null) {
                                        return const SizedBox();
                                      } else {
                                        return Text(
                                          model.customerName,
                                          style: const TextStyle(
                                              color: GFColors.DANGER,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        );
                                      }
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ],
                            ),
                    ],
                  )
                : (widget.adminUserModel != null)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Obx(() => CheckboxListTile(
                                  value: appController.receive.value,
                                  onChanged: (value) {
                                    appController.receive.value =
                                        !appController.receive.value;
                                  },
                                  title: const Text('รับสินค้า'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                )),
                          ),
                          Obx(() => appController.receive.value
                              ? Text(
                                  'คนรับ : ${widget.adminUserModel?.customerName ?? ""}',
                                  style:
                                      const TextStyle(color: GFColors.DANGER),
                                )
                              : const SizedBox()),
                          WidgetButton(
                              onPressed: () async {
                                if (appController.receive.value) {
                                  //receive

                                  AppService().processEditStatusByIdOrder(
                                      id: widget.orderWashModel.id,
                                      status: 'Receive',
                                      idAdminReceive: widget.adminUserModel!.id,
                                      idAdminOrder:
                                          widget.orderWashModel.idAdminOrder);
                                } else {
                                  //order

                                  AppService().processEditStatusByIdOrder(
                                      id: widget.orderWashModel.id,
                                      status: 'Order',
                                      idAdminReceive:
                                          widget.orderWashModel.idAdminReceive,
                                      idAdminOrder: widget.adminUserModel!.id);
                                }
                              },
                              text: 'บันทึก')
                        ],
                      )
                    : const SizedBox(),

            Text('data'),
          ],
        ),
      ],
    );
  }

  Row displayStartEnd() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('วันรับผ้า'),
              Text(widget.orderWashModel.dateStart),
              Text(widget.orderWashModel.timeStar),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('วันส่งผ้า'),
              Text(widget.orderWashModel.dateEnd),
              Text(widget.orderWashModel.timeEnd)
            ],
          ),
        ),
      ],
    );
  }
}
