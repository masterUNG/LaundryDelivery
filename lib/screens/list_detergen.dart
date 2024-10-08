import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_form.dart';

class ListDetergen extends StatefulWidget {
  const ListDetergen({super.key});

  @override
  State<ListDetergen> createState() => _ListDetergenState();
}

class _ListDetergenState extends State<ListDetergen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผงซักฝอก'),
      ),
      body: FutureBuilder(
        future: AppService().readAllTypeDetergen(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var typeDetergenModles = snapshot.data;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: typeDetergenModles!.length,
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: Get.width * 0.75,
                          child: Text(typeDetergenModles[index].typeDetergen)),
                      Text(typeDetergenModles[index].price),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: WidgetButton(
          onPressed: () {
            final formKey = GlobalKey<FormState>();

            TextEditingController nameController = TextEditingController();
            TextEditingController priceController = TextEditingController();

            AppDialog().normalDialog(
                title: 'เพิ่มผงซักฝอก',
                contentWidget: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WidgetForm(
                        controller: nameController,
                        labelText: 'ชื่อ :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'กรุณากรอกชื่อ';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      WidgetForm(
                        controller: priceController,
                        labelText: 'ราคา :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'กรุณากรอกราคา';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                firstAction: WidgetButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AppService()
                          .processAddDetergen(
                              typeDetergen: nameController.text,
                              price: priceController.text)
                          .then(
                        (value) {
                          Get.back();
                          setState(() {});
                        },
                      );
                    }
                  },
                  text: 'บันทึก',
                  type: GFButtonType.outline2x,
                ));
          },
          text: 'เพิ่มผงซักฝอก'),
    );
  }
}
