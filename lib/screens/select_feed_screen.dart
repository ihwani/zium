import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              radius: 16,
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
                  Get.toNamed("/office", arguments: Get.arguments);
                },
                child: Text(
                  Get.arguments['design_office'],
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
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
                fit: BoxFit.cover,
                imageUrl: Get.arguments['image_link'],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(children: [
              const Icon(Icons.location_on),
              Text(Get.arguments['location'])
            ]),
          ),
        ]),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(Get.arguments['project_name']),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Obx(
                  () => IconButton(
                    onPressed: () {
                      if (controller.bookMark
                          .contains(Get.arguments['project_id'])) {
                        controller.bookMark.remove(Get.arguments['project_id']);
                        bookMarkList.remove(Get.arguments);
                      } else {
                        controller.bookMark.add(Get.arguments['project_id']);
                        bookMarkList.add(Get.arguments);
                      }
                    },
                    icon: controller.bookMark
                            .contains(Get.arguments['project_id'])
                        ? const Icon(Icons.bookmark, color: Colors.red)
                        : const Icon(
                            Icons.bookmark_border,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Get.arguments['tag'].length,
              itemBuilder: (context, idx) {
                return TextButton(
                    onPressed: () {
                      Get.toNamed('/tag', arguments: Get.arguments['tag'][idx]);
                    },
                    child: Text('# ' + Get.arguments['tag'][idx]));
                // return Text('#' + Get.arguments['tag'][idx] + " ");
              },
            ),
          ),
        ),
      ]),
    );
  }
}
