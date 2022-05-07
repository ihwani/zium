import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    var size = MediaQuery.of(context).size;
    List _valueList = [];
    List _keyList = [];
    _valueList.addAll(controller.favorite.values);
    _keyList.addAll(controller.favorite.keys);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: const [
                  Text(
                    '저장된 사무소',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.favorite.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/office', arguments: _keyList[index]);
                    },
                    child: SizedBox(
                      width: 50,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: _valueList[index],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: const [
                  Text(
                    '저장된 피드',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: List.generate(
                    controller.bookMark.length,
                    (index) {
                      return SizedBox(
                        width: (size.width - 3) / 3,
                        height: (size.width - 3) / 3,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/select',
                                arguments: controller.bookMark[index]);
                          },
                          child: SizedBox(
                            child: CachedNetworkImage(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: controller.bookMark[index]
                                  ['image_link'],
                              placeholder: (context, url) => const Center(
                                  heightFactor: 30,
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
