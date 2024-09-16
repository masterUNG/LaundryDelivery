import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/screens/detail_order.dart';
import 'package:testdb/utility/app_service.dart';

class BodyListHistoryOwner extends StatelessWidget {
  const BodyListHistoryOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppService().processReadOrderWhereStatus(status: 'Finish'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var orderWashModels = snapshot.data!;

          if (orderWashModels.isEmpty) {
            return const Center(child: Text('ไม่มี Order'));
          } else {

            return ListView.builder(
              // reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: orderWashModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(DetailOrder(
                    orderWashModel: orderWashModels[index],
                    // adminUserModel: widget.userModel,
                  ))?.then(
                    (value) {
                      AppService().readAllOrderForAdmin();
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(orderWashModels[index].refWash),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.green),
                            child: Text(
                                orderWashModels[index].status),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(orderWashModels[index].dateStart),
                          Text(orderWashModels[index].dateEnd),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
