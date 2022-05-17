import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class TagScreen extends StatelessWidget {
  TagScreen({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      Controller(),
    );

    int widthAxisCount = context.width ~/ 300;
    int _axiisCount = widthAxisCount > 2 ? widthAxisCount : 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          '#' + tagName,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
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
      body: AnimationLimiter(
        child: MasonryGridView.count(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: tagList.length,
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
                        arguments: tagList[index],
                      );
                    },
                    child: ExtendedImage.network(
                      tagList[index]['image_link'],
                      fit: BoxFit.cover,
                      cache: true,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
            );
          },
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
      floatingActionButtonLocation: context.width < 600
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
    );
  }
}
