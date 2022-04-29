import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/util/util.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({Key? key}) : super(key: key);
  final List<Map> _foundDatas = bookMarkList;

  @override
  Widget build(BuildContext context) {
    List<Map> _randomList = _foundDatas;
    _randomList.shuffle();

    var size = MediaQuery.of(context).size;

    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Bookmark',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          spacing: 1,
          runSpacing: 1,
          children: List.generate(
            _foundDatas.length,
            (index) {
              return SizedBox(
                width: (size.width - 3) / 3,
                height: (size.width - 3) / 3,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/select', arguments: postList[index]);
                  },
                  child: SizedBox(
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: postList[index]['image_link'],
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
    );
  }
}
