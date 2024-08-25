import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/body_history.dart';
import 'package:testdb/widgets/body_map.dart';
import 'package:testdb/widgets/body_news.dart';
import 'package:testdb/widgets/body_profile.dart';
import 'package:testdb/widgets/widget_button.dart';

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

    AppService().findCurrentUserLogin();

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
            actions: [
              appController.indexBody.value == 3
                  ? Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: WidgetButton(
                          onPressed: () {
                            AppDialog().normalDialog(
                                title: 'Confirm SignOut',
                                firstAction: WidgetButton(
                                    type: GFButtonType.outline2x,
                                    onPressed: () async {
                                      await GetStorage().erase().then(
                                        (value) {
                                          Get.offAllNamed('/loginPage');
                                        },
                                      );
                                    },
                                    text: 'Confirm'));
                          },
                          text: 'SignOut'),
                    )
                  : const SizedBox(),
            ],
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
