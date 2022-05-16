import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(
    Controller(),
  );
  //검색 함수
  void _runFilter(String enteredKeyword) {
    List searchList = controller.postList;
    if (enteredKeyword.isEmpty) {
      keywordList.clear();
    } else {
      keywordList = searchList
          .where(
            (element) => element.toString().contains(enteredKeyword),
          )
          .toList();

      setState(() {
        keywordList.shuffle();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int widthAxisCount = context.width ~/ 300;
    int _axiisCount = widthAxisCount > 2 ? widthAxisCount : 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        //검색창
        title: TextField(
          onSubmitted: (value) => _runFilter(value),
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: '  Search',
            labelStyle: TextStyle(fontSize: 15),
            hintText: '  (사무소명, 건물용도, 지역)',
            hintStyle: TextStyle(color: Colors.black, fontSize: 15),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
      //검색 결과
      body: AnimationLimiter(
        child: MasonryGridView.count(
          controller: controller.scrollController.value,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: keywordList.length,
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
                      Get.toNamed('/select', arguments: keywordList[index]);
                    },
                    child: ExtendedImage.network(
                      keywordList[index]['image_link'],
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
