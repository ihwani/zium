import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      Controller(),
    );

    int widthAxisCount = context.width ~/ 300;
    int _axiisCount = widthAxisCount > 2 ? widthAxisCount : 2;

    controller.keyList.clear();
    controller.keyList.addAll(controller.favorite.keys);
    controller.keyList.shuffle();

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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(
              () => SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.favorite.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        officeList = controller.postList
                            .where(
                              (element) => element.toString().contains(
                                    controller.keyList[index],
                                  ),
                            )
                            .toList();
                        Get.toNamed(
                          "/office",
                        );
                      },
                      child: Card(
                        child: SizedBox(
                          height: 40,
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExtendedImage.network(
                              controller.favorite[controller.keyList[index]],
                              cache: true,
                            ),
                          ),
                        ),
                      ),
                    );
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
            child: AnimationLimiter(
              child: MasonryGridView.count(
                controller: controller.scrollController.value,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: controller.bookMark.length,
                crossAxisCount: _axiisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: _axiisCount,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              '/select',
                              arguments: controller.bookMark[index],
                            );
                          },
                          child: ExtendedImage.network(
                            controller.bookMark[index]['image_link'],
                            fit: BoxFit.cover,
                            cache: true,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 30,
        width: 30,
        child: FloatingActionButton(
          onPressed: () {
            controller.scrollToTop(controller.scrollController.value,
                controller.scrollController.value.offset ~/ 10);
          },
          backgroundColor: Colors.white,
          elevation: 2,
          child: const Icon(
            Icons.keyboard_arrow_up_sharp,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: context.width < 600
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
    );
  }
}
