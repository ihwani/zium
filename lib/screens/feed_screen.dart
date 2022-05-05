import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zium/getx/getx_controller.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    return Obx(
      () => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: ListView.builder(
          itemCount: controller.postList.length,
          itemBuilder: ((context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ).copyWith(
                    right: 0,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: controller.postList[index]['ic_link'],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed("/office",
                                arguments: controller.postList[index]);
                          },
                          child: Text(
                            controller.postList[index]['design_office'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("select",
                          arguments: controller.postList[index]);
                    },
                    child: SizedBox(
                      child: CachedNetworkImage(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: controller.postList[index]['image_link'],
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(children: [
                      const Icon(Icons.location_on),
                      Text(controller.postList[index]['location'])
                    ]),
                  ),
                ]),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(controller.postList[index]['project_name']),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Obx(
                          () => IconButton(
                            onPressed: () {
                              if (controller.bookMark
                                  .toString()
                                  .contains(controller.postList[index]['id'])) {
                                controller.bookMark
                                    .remove(controller.postList[index]);
                                Hive.box('SaveData')
                                    .put('BookMark', controller.bookMark);
                              } else {
                                controller.bookMark
                                    .add(controller.postList[index]);
                                Hive.box('SaveData')
                                    .put('BookMark', controller.bookMark);
                              }
                            },
                            icon: controller.bookMark
                                    .toString()
                                    .contains(controller.postList[index]['id'])
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
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.postList[index]['tag'].length,
                      itemBuilder: (context, idx) {
                        return Row(children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                            ),
                            onPressed: () {
                              Get.toNamed('/tag',
                                  arguments: controller.postList[index]['tag']
                                      [idx]);
                            },
                            child: Text(
                              '# ' + controller.postList[index]['tag'][idx],
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
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
