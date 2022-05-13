import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

    var size = MediaQuery.of(context).size;
    int widthAxisCount = size.width ~/ 300;

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
      body: MasonryGridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: foundList.length,
        crossAxisCount: widthAxisCount > 2 ? widthAxisCount : 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/select', arguments: foundList[index]);
            },
            child: ExtendedImage.network(
              foundList[index]['image_link'],
              fit: BoxFit.cover,
              cache: true,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          );
        },
      ),
    );
  }
}
