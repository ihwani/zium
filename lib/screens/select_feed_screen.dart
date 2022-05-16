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
    Map _argumentsData = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExtendedImage.network(
                  _argumentsData['ic_link'],
                  cache: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextButton(
                onPressed: () {
                  Get.toNamed("/office",
                      arguments: _argumentsData['office_id']);
                },
                child: Text(
                  _argumentsData['design_office'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
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
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('select_image', arguments: _argumentsData);
                },
                child: ExtendedImage.network(
                  _argumentsData['image_link'],
                  fit: BoxFit.contain,
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(children: [
              const Icon(Icons.location_on),
              const SizedBox(
                width: 8,
              ),
              Text(
                _argumentsData['location'],
                overflow: TextOverflow.ellipsis,
              )
            ]),
          ),
          ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  _argumentsData['project_name'],
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
                        .contains(_argumentsData['id'])) {
                      controller.bookMark.remove(_argumentsData);
                      Hive.box('BookMark').put('BookMark', controller.bookMark);
                    } else {
                      controller.bookMark.add(_argumentsData);
                      Hive.box('BookMark').put('BookMark', controller.bookMark);
                    }
                  },
                  icon: controller.bookMark
                          .toString()
                          .contains(_argumentsData['id'])
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
                itemCount: _argumentsData['tag'].length,
                itemBuilder: (context, idx) {
                  return Row(children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                      ),
                      onPressed: () {
                        Get.toNamed('/tag',
                            arguments: _argumentsData['tag'][idx]);
                      },
                      child: Text(
                        '# ' + _argumentsData['tag'][idx],
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
