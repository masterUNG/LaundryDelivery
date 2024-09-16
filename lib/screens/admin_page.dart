// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/detail_order.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_signout.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().readAllOrderForAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offier : ${widget.userModel.customerName}'),actions: const[WidgetSignOut()],
      ),


      body: Obx(() => appController.orderWashModels.isEmpty
          ? const Center(child: CircularProgressIndicator())



          : ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appController.orderWashModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(DetailOrder(
                    orderWashModel: appController.orderWashModels[index],
                    adminUserModel: widget.userModel,
                  ))?.then(
                    (value) {
                      AppService().readAllOrderForAdmin();
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appController.orderWashModels[index].refWash),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: appController
                                            .orderWashModels[index].status ==
                                        'Order'
                                    ? Colors.green
                                    : appController.orderWashModels[index]
                                                .status ==
                                            'Receive'
                                        ? Colors.orange
                                        : appController.orderWashModels[index]
                                                    .status ==
                                                'Payment'
                                            ? Colors.pink.shade200
                                            : Colors.blue),
                            child: Text(
                                appController.orderWashModels[index].status),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appController.orderWashModels[index].dateStart),
                          Text(appController.orderWashModels[index].dateEnd),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            
            
            ),



    );
  }
}
