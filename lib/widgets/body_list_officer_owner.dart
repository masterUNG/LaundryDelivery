import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/screens/register.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class BodyListOfficerOwner extends StatefulWidget {
  const BodyListOfficerOwner({super.key});

  @override
  State<BodyListOfficerOwner> createState() => _BodyListOfficerOwnerState();
}

class _BodyListOfficerOwnerState extends State<BodyListOfficerOwner> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          FutureBuilder(
            future: AppService().processReadUserWhereStatus(status: 'officer'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userModlels = snapshot.data;

                if (userModlels!.isEmpty) {
                  return const Center(child: Text('ไม่มีพนักงาน'));
                } else {



                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: userModlels.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      'ชื่อ : ${userModlels[index].customerName}')),
                              Expanded(
                                  child: Text(
                                      'นามสกุล : ${userModlels[index].lastName}')),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                      'ที่อยู่ : ${userModlels[index].address}')),
                              Expanded(
                                  child: Text(
                                      'เบอร์โทร : ${userModlels[index].phoneNumber}')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );







                  
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0,
            right: 16,
            child: WidgetButton(
              onPressed: () {
                Get.to(Register(status: 'officer'))?.then((value) {
                  setState(() {});
                });
              },
              text: 'เพิ่ม Officer',
            ),
          ),
        ],
      ),
    );
  }
}
