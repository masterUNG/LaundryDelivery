import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/screens/login_page.dart';
import 'package:testdb/utility/app_http_override.dart';

void main() {
  HttpOverrides.global = AppHttpOverride();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
