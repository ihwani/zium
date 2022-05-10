import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class TagScreen extends StatelessWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      Controller(),
    );
    getSearch(controller.postList, Get.arguments);

    foundList.shuffle();

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          '#' + Get.arguments.toString(),
          style: const TextStyle(color: Colors.black),
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
      body: SingleChildScrollView(
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
                      placeholder: (context, url) => const Center(
                          heightFactor: 30, child: CircularProgressIndicator()),
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
    );
  }
}
