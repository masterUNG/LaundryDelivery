import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_form.dart';

class ListProdut extends StatefulWidget {
  const ListProdut({super.key});

  @override
  State<ListProdut> createState() => _ListProdutState();
}

class _ListProdutState extends State<ListProdut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผลิดภัณท์'),
      ),
      body: FutureBuilder(
        future: AppService().readAllTypeCloths(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var typeClothModels = snapshot.data;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: typeClothModels!.length,
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(typeClothModels[index].typeCloths),
                      Text(typeClothModels[index].price),
                    ],
                  ),
                  Divider(),
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
                title: 'เพิ่มผลิดภัณท์',
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
                          .processAddProduct(
                              typeCloth: nameController.text,
                              price: priceController.text)
                          .then((value) {
                        Get.back();
                        setState(() {});
                      });
                    }
                  },
                  text: 'บันทึก',
                  type: GFButtonType.outline2x,
                ));








                
          },
          text: 'เพิ่มผลิดภัณท์'),
    );
  }
}
