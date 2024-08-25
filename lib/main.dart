import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testdb/screens/login_page.dart';
import 'package:testdb/screens/main_home.dart';
import 'package:testdb/utility/app_http_override.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: '/loginPage',
    page: () => const LoginPage(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const MainHome(),
  ),
];

String? firstPage;

Future<void> main() async {
  HttpOverrides.global = AppHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init().then(
    (value) {
      var result = GetStorage().read('data');
      print('## result ====> $result');

      if (result == null) {

        firstPage = '/loginPage';
        runApp(const MyApp());

      } else {

        firstPage = '/mainHome';
        runApp(const MyApp());

      }
    },
  );

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: getPages,
      initialRoute: firstPage,
      // home: const LoginPage(),
    );
  }
}
