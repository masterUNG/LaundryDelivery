import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final keyForm = GlobalKey<FormState>();

  TextEditingController customerName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  var insertSt = "";

  final IP = '192.168.1.243';

  void insertOrder(String un, String pw, String eml) async {
    try {
      String url =
          "http://${IP}/flutter_login/register.php?name=$un&password=$pw&email=$eml";

      print(url);
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var rs = response.body.replaceAll('ï»¿', '');
        var rsInsert = convert.jsonDecode(rs);

        setState(() {
          insertSt = rsInsert['add'];
          if (insertSt.contains('OK')) {
            print('ok');
            //alert สั่งซื้อสำเร็จ
          } else {
            //alert มีข้อผิดพลาด
            print('no');
          }
          //Navigator.pop(context);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    AppService().processFindPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิก'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                child: Form(
                  key: keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WidgetForm(controller: customerName,
                        labelText: 'Name :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'Please Fill Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      WidgetForm(controller: lastName,
                        labelText: 'Surname :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดกรอก Surname';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      WidgetForm(controller: phoneNumber,
                        labelText: 'Phone :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดกรอก Phone';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      WidgetForm(controller: address,
                        labelText: 'Address :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดกรอก Address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      WidgetForm(controller: email,
                        labelText: 'Email :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดกรอก Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      WidgetForm(controller: pass,
                        labelText: 'Password :',
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'โปรดกรอก Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      GetX<AppController>(
                        init: AppController(),
                        initState: (_) {},
                        builder: (AppController appController) {
                          return appController.positions.isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  width: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Location :'),
                                      Text(
                                          'ละติจูต : ${appController.positions.last.latitude}'),
                                      Text(
                                          'ลองติจูต : ${appController.positions.last.longitude}'),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetButton(
              onPressed: () {
                if (keyForm.currentState!.validate()) {

                  AppController appController = Get.put(AppController());

                  AppService().processRegister(
                      name: customerName.text,
                      surName: lastName.text,
                      phoneNumber: phoneNumber.text,
                      address: address.text,
                      email: email.text,
                      password: pass.text,
                      lat: appController.positions.last.latitude.toString(),
                      lng: appController.positions.last.longitude.toString(),);
                }
              },
              text: 'สมัครสมาชิก'),
        ],
      ),
    );
  }
}
