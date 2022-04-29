import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.builder(
        itemCount: postList.length,
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
                        imageUrl: postList[index]['ic_link'],
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
                          Get.toNamed("/office", arguments: postList[index]);
                        },
                        child: Text(
                          postList[index]['design_office'],
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
                    launchURL(postList[index]['project_link']);
                  },
                  child: SizedBox(
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: postList[index]['image_link'],
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
                    Text(postList[index]['location'])
                  ]),
                ),
              ]),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(postList[index]['project_name']),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Obx(
                        () => IconButton(
                          onPressed: () {
                            if (controller.bookMark
                                .contains(postList[index]['project_id'])) {
                              controller.bookMark
                                  .remove(postList[index]['project_id']);
                              bookMarkList.remove(postList[index]);
                            } else {
                              controller.bookMark
                                  .add(postList[index]['project_id']);
                              bookMarkList.add(postList[index]);
                            }
                          },
                          icon: controller.bookMark
                                  .contains(postList[index]['project_id'])
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
                    itemCount: postList[index]['tag'].length,
                    itemBuilder: (context, idx) {
                      return TextButton(
                          onPressed: () {
                            Get.toNamed('/tag',
                                arguments: postList[index]['tag'][idx]);
                          },
                          child: Text('# ' + postList[index]['tag'][idx]));
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
    );
  }
}
