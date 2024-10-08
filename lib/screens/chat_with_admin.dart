import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/models/message_model.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_form.dart';
import 'package:testdb/widgets/widget_icon_button.dart';

class ChatWithAdmin extends StatefulWidget {
  const ChatWithAdmin({super.key});

  @override
  State<ChatWithAdmin> createState() => _ChatWithAdminState();
}

class _ChatWithAdminState extends State<ChatWithAdmin> {
  AppController appController = Get.put(AppController());

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    AppService().processCheckHaveCustomer();

    AppService().readAllMessageWhereCustomerIdUser(
        customerIdUser: appController.currentUserModels.last.customerId);
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
                      isSender: appController.currentUserModels.last.customerId == appController.messageModels[index].customerId,
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
                String customerId =
                    appController.currentUserModels.last.customerId;
                print('## customerId ---> $customerId');

                MessageModel model = MessageModel(
                    customerId: customerId,
                    message: textEditingController.text,
                    timestamp: Timestamp.fromDate(DateTime.now()));

                AppService().processSendMessage(messageModel: model).then(
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
