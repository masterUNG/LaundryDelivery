import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_form.dart';
import 'package:testdb/widgets/widget_icon_button.dart';

class BodyNews extends StatefulWidget {
  const BodyNews({super.key});

  @override
  State<BodyNews> createState() => _BodyNewsState();
}

class _BodyNewsState extends State<BodyNews> {
  AppController appController = Get.put(AppController());

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            FutureBuilder(
              future: AppService().processReadAllNews(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var newsModels = snapshot.data;

                  return ListView.builder(
                    itemCount: newsModels!.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(border: Border.all()),

                      padding: const EdgeInsets.all(8),

                      margin: const EdgeInsets.only(
                        bottom: 8,
                        left: 8,
                        right: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsModels[index].timePost,
                            style: const TextStyle(color: Colors.red),
                          ),
                          Text(newsModels[index].post),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            appController.currentUserModels.isEmpty ? Positioned(
                bottom: 0,
                child: SizedBox(
                    width: Get.width,
                    child: WidgetForm(
                      controller: textEditingController,
                      hintText: 'Post',
                      suffixIcon: WidgetIconButton(
                        iconData: Icons.send,
                        onPressed: () {
                          if (textEditingController.text.isNotEmpty) {
                            String post = textEditingController.text;
                            String timePost = AppService()
                                .changeDateTimeToString(
                                    dateTime: DateTime.now());

                            print('post --> $post, timePost --> $timePost');

                            AppService()
                                .processAddNews(post: post, timePost: timePost)
                                .then(
                              (value) {
                                textEditingController.clear();

                                FocusManager.instance.primaryFocus?.unfocus();

                                setState(() {});
                              },
                            );
                          }
                        },
                      ),
                    ))) : const SizedBox(),
          ],
        ),
      )),
    );
  }
}
