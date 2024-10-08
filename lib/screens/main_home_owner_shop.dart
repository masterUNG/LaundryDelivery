import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/screens/list_detergen.dart';
import 'package:testdb/screens/list_produt.dart';
import 'package:testdb/screens/list_softener.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/widgets/body_list_customer_owner.dart';
import 'package:testdb/widgets/body_list_history_owner.dart';
import 'package:testdb/widgets/body_list_officer_owner.dart';
import 'package:testdb/widgets/body_list_income_owner.dart';
import 'package:testdb/widgets/body_news.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_signout.dart';

class MainHomeOwnerShop extends StatefulWidget {
  const MainHomeOwnerShop({super.key});

  @override
  State<MainHomeOwnerShop> createState() => _MainHomeOwnerShopState();
}

class _MainHomeOwnerShopState extends State<MainHomeOwnerShop> {
  AppController appController = Get.put(AppController());

  var bodys = <Widget>[
    const BodyListOfficerOwner(),
    const BodyListCustomerOwner(),
    const BodyListIncomeOwner(),
    const BodyListHistoryOwner(),
  ];

  var titles = <String>[
    'Officer',
    'Customer',
    'Income',
    'History',
  ];

  var iconsData = <IconData>[
    Icons.group,
    Icons.face,
    Icons.money,
    Icons.history,
  ];

  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < bodys.length; i++) {
      items.add(
          BottomNavigationBarItem(icon: Icon(iconsData[i]), label: titles[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(titles[appController.indexBody.value]),
          ),
          endDrawer: Drawer(
            child: Column(
              children: [
                const UserAccountsDrawerHeader(
                    accountName: Text('Admin'), accountEmail: Text('Only')),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('Post'),
                  onTap: () {
                    Get.to(const BodyNews());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('ผลิดภัณท์'),
                  onTap: () {
                    Get.to(const ListProdut());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('ผงซักฝอก'),
                  onTap: () {
                    Get.to(const ListDetergen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('น้ำยาปรับผ้านุ่ม'),
                  onTap: () {
                    Get.to(const ListSoftener());
                  },
                ),
                const Spacer(),
                const ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: WidgetSignOut(),
                ),
              ],
            ),
          ),
          body: bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: appController.indexBody.value,
            items: items,
            onTap: (value) {
              appController.indexBody.value = value;
            },
          ),
        ));
  }
}
