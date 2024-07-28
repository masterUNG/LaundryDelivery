import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/widgets/body_history.dart';
import 'package:testdb/widgets/body_map.dart';
import 'package:testdb/widgets/body_news.dart';
import 'package:testdb/widgets/body_profile.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var bodys = <Widget>[
    const BodyMap(),
    const BodyNews(),
    const BodyHistory(),
    const BodyProfile(),
  ];

  var titles = <String>[
    'Home',
    'News',
    'History',
    'Profile',
  ];

  var iconDatas = <IconData>[
    Icons.home,
    Icons.newspaper,
    Icons.history,
    Icons.person,
  ];

  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < bodys.length; i++) {
      items.add(
          BottomNavigationBarItem(icon: Icon(iconDatas[i]), label: titles[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      init: AppController(),
      initState: (_) {},
      builder: (AppController appController) {
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[appController.indexBody.value]),
          ),
          body: bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            currentIndex: appController.indexBody.value,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {

              appController.indexBody.value = value;
              
            },
          ),
        );
      },
    );
  }
}
