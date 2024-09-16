import 'package:flutter/material.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/utility/app_service.dart';

class BodyListIncomeOwner extends StatelessWidget {
  const BodyListIncomeOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppService().processReadOrderWhereStatus(status: 'Finish'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var orderWashModels = snapshot.data!;

          if (orderWashModels.isEmpty) {
            return Text('ยังไม่มี order');
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                displayHead(),
                displayContent(orderWashModels),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Total : ${AppService().calculateTotal(orderWashModels: orderWashModels)}'),
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
                    const SizedBox(height: 30,
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(orderWashModels[index].dateStart, style: const TextStyle(fontSize: 12)),
                    ),
                     const SizedBox(height: 30,
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(orderWashModels[index].dateEnd, style: const TextStyle(fontSize: 12)),
                    ),
                     const SizedBox(height: 30,
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(orderWashModels[index].amountCloth),
                    ),
                     const SizedBox(height: 30,
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(orderWashModels[index].total),
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
                      child: Text('Amt'),
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
