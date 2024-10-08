import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/type_cloths_model.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';

class BodyListIncomeOwner extends StatefulWidget {
  const BodyListIncomeOwner({super.key});

  @override
  State<BodyListIncomeOwner> createState() => _BodyListIncomeOwnerState();
}

class _BodyListIncomeOwnerState extends State<BodyListIncomeOwner> {
  AppController appController = Get.put(AppController());

  int total = 0;

  @override
  void initState() {
    super.initState();

    processCalTotal();
  }

  Future<void> processCalTotal() async {
    var orderWashModels =
        await AppService().processReadOrderWhereStatus(status: 'Finish');

    for (var element in orderWashModels) {
      var typeClothModels = await AppService()
          .readAllTypeClothsFromAmountCloth(amountCloth: element.amountCloth);

      int sum = await AppService()
          .calculateGrandTotal(typeClothsModels: typeClothModels);

      total = total + sum;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppService().processReadOrderWhereStatus(status: 'Finish'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var orderWashModels = snapshot.data!;

          if (orderWashModels.isEmpty) {
            return const Text('ยังไม่มี order');
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                displayHead(),
                displayContent(orderWashModels),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Total : $total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListView displayContent(List<OrderWashModel> orderWashModels) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: orderWashModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(orderWashModels[index].refWash),
          ),
          const SizedBox(
            height: 30,
            child: VerticalDivider(),
          ),
          Expanded(
            flex: 2,
            child: Text(orderWashModels[index].dateStart,
                style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(
            height: 30,
            child: VerticalDivider(),
          ),
          Expanded(
            flex: 2,
            child: Text(orderWashModels[index].dateEnd,
                style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(
            height: 30,
            child: VerticalDivider(),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: AppService().readAllTypeClothsFromAmountCloth(
                  amountCloth: orderWashModels[index].amountCloth),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TypeClothsModel> typeClothModels = snapshot.data!;

                  // total = total +
                  //     AppService().calculateGrandTotal(
                  //         typeClothsModels: typeClothModels);

                  // setState(() {});

                  return Text(
                      '${AppService().calculateGrandTotal(typeClothsModels: typeClothModels)}');
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container displayHead() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Ref'),
          ),
          Expanded(
            flex: 2,
            child: Text('Start'),
          ),
          Expanded(
            flex: 2,
            child: Text('End'),
          ),
          Expanded(
            flex: 1,
            child: Text('Sum'),
          ),
        ],
      ),
    );
  }
}
