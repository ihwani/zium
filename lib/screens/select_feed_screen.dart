import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class SelectFeedScreen extends StatelessWidget {
  const SelectFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                imageUrl: Get.arguments['ic_link'],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextButton(
                onPressed: () {
                  Get.toNamed("/office", arguments: Get.arguments['office_id']);
                },
                child: Text(
                  Get.arguments['design_office'],
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ).copyWith(
            right: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GestureDetector(
            onTap: () {
              launchURL(Get.arguments['project_link']);
            },
            child: SizedBox(
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                fit: BoxFit.contain,
                imageUrl: Get.arguments['image_link'],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(children: [
            const Icon(Icons.location_on),
            const SizedBox(
              width: 8,
            ),
            Text(Get.arguments['location'])
          ]),
        ),
        ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Text(Get.arguments['project_name']),
            ),
            trailing:
                //북마크 저장
                Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.bookMark
                      .toString()
                      .contains(Get.arguments['id'])) {
                    controller.bookMark.remove(Get.arguments);
                    Hive.box('BookMark').put('BookMark', controller.bookMark);
                  } else {
                    controller.bookMark.add(Get.arguments);
                    Hive.box('BookMark').put('BookMark', controller.bookMark);
                  }
                },
                icon:
                    controller.bookMark.toString().contains(Get.arguments['id'])
                        ? const Icon(Icons.bookmark, color: Colors.red)
                        : const Icon(
                            Icons.bookmark_border,
                          ),
              ),
            )),
        //태그 배열
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Get.arguments['tag'].length,
              itemBuilder: (context, idx) {
                return Row(children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                    ),
                    onPressed: () {
                      Get.toNamed('/tag', arguments: Get.arguments['tag'][idx]);
                    },
                    child: Text(
                      '# ' + Get.arguments['tag'][idx],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ]);
              },
            ),
          ),
        ),
      ]),
    );
  }
}
