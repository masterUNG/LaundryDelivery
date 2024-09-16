// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testdb/models/message_model.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_form.dart';
import 'package:testdb/widgets/widget_icon_button.dart';

class ChatWithCustomer extends StatefulWidget {
  const ChatWithCustomer({
    Key? key,
    required this.customerId,
    required this.customerIdAdmin,
  }) : super(key: key);

  final String customerId;
  final String customerIdAdmin;

  @override
  State<ChatWithCustomer> createState() => _ChatWithCustomerState();
}

class _ChatWithCustomerState extends State<ChatWithCustomer> {
  AppController appController = Get.put(AppController());

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // AppService().processCheckHaveCustomer();

    AppService()
        .readAllMessageWhereCustomerIdUser(customerIdUser: widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Obx(() => appController.messageModels.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: appController.messageModels.length,
                    itemBuilder: (context, index) => BubbleSpecialThree(
                      text: appController.messageModels[index].message,
                      color: Colors.amber,
                      isSender: widget.customerIdAdmin == appController.messageModels[index].customerId,
                    ),
                  )),
            messageForm(),
          ],
        ),
      ),
    );
  }

  Positioned messageForm() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: Get.width,
        child: WidgetForm(
          hintText: 'Message',
          controller: textEditingController,
          suffixIcon: WidgetIconButton(
            iconData: Icons.send,
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                String customerId = widget.customerId;

                print('## customerId ---> $customerId');

                MessageModel model = MessageModel(
                    customerId: widget.customerIdAdmin,
                    message: textEditingController.text,
                    timestamp: Timestamp.fromDate(DateTime.now()));

                AppService()
                    .processSendMessage(
                        messageModel: model,
                        customerId: customerId)
                    .then(
                  (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    textEditingController.clear();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
