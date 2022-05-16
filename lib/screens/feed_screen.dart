import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    int widthAxisCount = context.width ~/ 300;
    int _axiisCount = widthAxisCount > 1 ? widthAxisCount : 1;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => onRefresh(controller.postList),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            color: Colors.white10,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Obx(
              () => AnimationLimiter(
                child: MasonryGridView.count(
                  controller: _scrollController,
                  itemCount: controller.postList.length,
                  crossAxisCount: _axiisCount,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: ((context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: _axiisCount,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 4),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 36,
                                        width: 36,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: ExtendedImage.network(
                                          controller.postList[index]['ic_link'],
                                          cache: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: TextButton(
                                          onPressed: () {
                                            Get.toNamed("/office",
                                                arguments:
                                                    controller.postList[index]
                                                        ['office_id']);
                                          },
                                          child: Text(
                                            controller.postList[index]
                                                ['design_office'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('select_image',
                                          arguments:
                                              controller.postList[index]);
                                    },
                                    child: ExtendedImage.network(
                                      controller.postList[index]['image_link'],
                                      fit: BoxFit.fitWidth,
                                      cache: true,
                                      width: context.width,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        controller.postList[index]['location'],
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 32.0),
                                    child: Text(
                                      controller.postList[index]
                                          ['project_name'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  trailing:
                                      //북마크 저장
                                      Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        if (controller.bookMark
                                            .toString()
                                            .contains(controller.postList[index]
                                                ['id'])) {
                                          controller.bookMark.remove(
                                              controller.postList[index]);
                                          Hive.box('BookMark').put(
                                              'BookMark', controller.bookMark);
                                        } else {
                                          controller.bookMark
                                              .add(controller.postList[index]);
                                          Hive.box('BookMark').put(
                                              'BookMark', controller.bookMark);
                                        }
                                      },
                                      icon: controller.bookMark
                                              .toString()
                                              .contains(controller
                                                  .postList[index]['id'])
                                          ? const Icon(Icons.bookmark,
                                              color: Colors.red)
                                          : const Icon(
                                              Icons.bookmark_border,
                                            ),
                                    ),
                                  ),
                                ),
                                //태그 배열
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: SizedBox(
                                    height: 40,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                          .postList[index]['tag'].length,
                                      itemBuilder: (context, idx) {
                                        return Row(
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue.shade50,
                                              ),
                                              onPressed: () {
                                                Get.toNamed('/tag',
                                                    arguments: controller
                                                            .postList[index]
                                                        ['tag'][idx]);
                                              },
                                              child: Text(
                                                '# ' +
                                                    controller.postList[index]
                                                        ['tag'][idx],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
      floatingActionButton: SizedBox(
        height: 30,
        width: 30,
        child: FloatingActionButton(
          onPressed: () {
            controller.scrollToTop(
                _scrollController, _scrollController.offset ~/ 10);
          },
          backgroundColor: Colors.white,
          elevation: 2,
          child: const Icon(
            Icons.keyboard_arrow_up_sharp,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
