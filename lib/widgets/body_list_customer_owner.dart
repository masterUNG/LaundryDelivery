import 'package:flutter/material.dart';
import 'package:testdb/utility/app_service.dart';

class BodyListCustomerOwner extends StatefulWidget {
  const BodyListCustomerOwner({super.key});

  @override
  State<BodyListCustomerOwner> createState() => _BodyListCustomerOwnerState();
}

class _BodyListCustomerOwnerState extends State<BodyListCustomerOwner> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppService().processReadUserWhereStatus(status: 'user'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userModels = snapshot.data!;
          if (userModels.isEmpty) {
            return const Text('ไม่มี Customer');
          } else {
            return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: userModels.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      'ชื่อ : ${userModels[index].customerName}')),
                              Expanded(
                                  child: Text(
                                      'นามสกุล : ${userModels[index].lastName}')),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                      'ที่อยู่ : ${userModels[index].address}')),
                              Expanded(
                                  child: Text(
                                      'เบอร์โทร : ${userModels[index].phoneNumber}')),
                            ],
                          ),
                        ],
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
