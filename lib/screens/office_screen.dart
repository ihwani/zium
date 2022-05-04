import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/util/util.dart';

class OfficeScreen extends StatelessWidget {
  OfficeScreen({Key? key}) : super(key: key);
  final List<Map> foundList = postList
      .where(
        (element) =>
            element.toString().contains(Get.arguments['design_office']),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    foundList.shuffle();

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                imageUrl: Get.arguments['ic_link'],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              '  ' + Get.arguments['design_office'],
              style: const TextStyle(color: Colors.black),
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
                )),
          )
        ],
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                launchURL(Get.arguments['homepage_link']);
              },
              child: const Text(
                '홈페이지로 이동하기',
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: 1,
              runSpacing: 1,
              children: List.generate(
                foundList.length,
                (index) {
                  return SizedBox(
                    width: (size.width - 3) / 3,
                    height: (size.width - 3) / 3,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/select', arguments: foundList[index]);
                      },
                      child: SizedBox(
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: foundList[index]['image_link'],
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
        ],
      ),
    );
  }
}
