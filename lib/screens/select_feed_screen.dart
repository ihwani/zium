import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/screens/select_feed_screen/landscape_screen.dart';
import 'package:zium/screens/select_feed_screen/portrait_screen.dart';
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
      body: context.width > context.height
          ? const LandscapeScreen()
          : const PortraitScreen(),
    );
  }
}
