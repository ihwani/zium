import 'package:extended_image/extended_image.dart';
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
    final controller = Get.put(
      Controller(),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white,
              ),
              child: ExtendedImage.network(
                selectMap['ic_link'],
                cache: true,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    onPressed: () {
                      officeList = controller.postList
                          .where(
                            (element) => element.toString().contains(
                                  selectMap['office_id'],
                                ),
                          )
                          .toList();
                      Get.toNamed(
                        "/office",
                      );
                    },
                    child: Text(
                      selectMap['design_office'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('select_image');
                },
                child: ExtendedImage.network(
                  selectMap['image_link'],
                  fit: BoxFit.cover,
                  cache: true,
                  width: context.width,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: [
              const Icon(Icons.location_on),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  selectMap['location'],
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectMap['project_name'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ), //북마크 저장
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      onPressed: () {
                        if (controller.bookMark
                            .toString()
                            .contains(selectMap['id'])) {
                          controller.bookMark.remove(selectMap);
                          Hive.box('BookMark')
                              .put('BookMark', controller.bookMark);
                        } else {
                          controller.bookMark.add(selectMap);
                          Hive.box('BookMark')
                              .put('BookMark', controller.bookMark);
                        }
                      },
                      icon: controller.bookMark
                              .toString()
                              .contains(selectMap['id'])
                          ? const Icon(Icons.bookmark, color: Colors.red)
                          : const Icon(
                              Icons.bookmark_border,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //태그 배열
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectMap['tag'].length,
                itemBuilder: (context, idx) {
                  return Row(children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                      ),
                      onPressed: () {
                        tagList = controller.postList
                            .where(
                              (element) => element.toString().contains(
                                    selectMap['tag'][idx],
                                  ),
                            )
                            .toList();
                        tagName = selectMap['tag'][idx];
                        Get.toNamed("/tag");
                      },
                      child: Text(
                        '# ' + selectMap['tag'][idx],
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
      ),
    );
  }
}
