import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zium/getx/getx_controller.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    var size = MediaQuery.of(context).size;
    controller.keyList.clear();
    controller.keyList.addAll(controller.favorite.keys);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Text(
              '저장된 사무소',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: SizedBox(
                      height: 100,
                      width: 320,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "저장된 사무소를 전부 삭제하시겠습니까?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("취소")),
                              const SizedBox(
                                width: 30,
                              ),
                              TextButton(
                                onPressed: () {
                                  Hive.box('Favorite').delete('Favorite');
                                  controller.keyList.clear();
                                  controller.favorite.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text("확인"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.close),
            ),
          ),
          //저장된 사무소 배치
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Obx(
              () => SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.favorite.length,
                  itemBuilder: ((context, index) {
                    return Row(children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/office',
                              arguments: controller.keyList[index]);
                        },
                        child: SizedBox(
                          width: 50,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: controller
                                  .favorite[controller.keyList[index]],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      )
                    ]);
                  }),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            leading: const Text(
              '저장된 피드',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: SizedBox(
                      height: 100,
                      width: 320,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "저장된 피드를 전부 삭제하시겠습니까?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("취소")),
                              const SizedBox(
                                width: 30,
                              ),
                              TextButton(
                                onPressed: () {
                                  Hive.box('BookMark').delete('BookMark');
                                  controller.bookMark.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text("확인"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.close),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //저장된 피드 배치
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
                        width: (size.width - 2) / 2,
                        height: (size.width - 2) / 2,
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
