import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    final List _foundList = controller.postList
        .where(
          (element) => element.toString().contains(Get.arguments),
        )
        .toList();

    _foundList.shuffle();

    var size = MediaQuery.of(context).size;

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
                imageUrl: _foundList[0]['ic_link'],
                placeholder: (context, url) => const Center(
                    heightFactor: 30, child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              '  ' + _foundList[0]['design_office'],
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
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
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton(
                onPressed: () {
                  launchURL(_foundList[0]['homepage_link']);
                },
                child: const Text(
                  '홈페이지로 이동하기',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      List result = [];
                      result.addAll(controller.favorite.keys);
                      if (result.contains(Get.arguments)) {
                        controller.favorite.remove(Get.arguments);
                        Hive.box('Favorite')
                            .put('Favorite', controller.favorite);
                      } else {
                        controller.favorite[Get.arguments] =
                            _foundList[0]['ic_link'];
                        Hive.box('Favorite')
                            .put('Favorite', controller.favorite);
                      }
                    },
                    icon: controller.favorite.toString().contains(Get.arguments)
                        ? const Icon(Icons.star, color: Colors.red)
                        : const Icon(
                            Icons.star_border,
                          ),
                  ),
                ),
              ),
            ),
          ]),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 1,
                runSpacing: 1,
                children: List.generate(
                  _foundList.length,
                  (index) {
                    return SizedBox(
                      width: (size.width - 3) / 3,
                      height: (size.width - 3) / 3,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/select', arguments: _foundList[index]);
                        },
                        child: SizedBox(
                          child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: _foundList[index]['image_link'],
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
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
        ],
      ),
    );
  }
}
