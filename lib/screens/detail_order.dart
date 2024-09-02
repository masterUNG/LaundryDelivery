// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({
    Key? key,
    required this.orderWashModel,
    required this.adminUserModel,
  }) : super(key: key);

  final OrderWashModel orderWashModel;
  final UserModel adminUserModel;

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
                    Text('ที่อยู่ : ${model.address}')
                  ],
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

  Widget displayDetail() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('จำนวนเลือผ้า : ${widget.orderWashModel.amountCloth} ชิ้น'),
            Text('ผงซักฝอก : ${widget.orderWashModel.detergen}'),
            Text('น้ำยาปรับผ้านุ่ม : ${widget.orderWashModel.softener}'),
          ],
        ),
        Column(
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
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
            ),
            Obx(() => appController.receive.value
                ? Text(
                    'คนรับ : ${widget.adminUserModel.customerName}',
                    style: const TextStyle(color: GFColors.DANGER),
                  )
                : const SizedBox()),
            WidgetButton(
                onPressed: () async {
                  if (appController.receive.value) {
                    //receive

                    AppService().processEditStatusByIdOrder(
                        id: widget.orderWashModel.id,
                        status: 'Receive',
                        idAdminReceive: widget.adminUserModel.id,
                        idAdminOrder: widget.orderWashModel.idAdminOrder);
                  } else {
                    //order

                    AppService().processEditStatusByIdOrder(
                        id: widget.orderWashModel.id,
                        status: 'Order',
                        idAdminReceive: widget.orderWashModel.idAdminReceive,
                        idAdminOrder: widget.adminUserModel.id);
                  }
                },
                text: 'บันทึก')
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
