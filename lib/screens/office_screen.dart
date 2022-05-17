import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:word_break_text/word_break_text.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class OfficeScreen extends StatelessWidget {
  OfficeScreen({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      Controller(),
    );

    var _officeData = officeList[0];

    int widthAxisCount = context.width ~/ 300;
    int _axiisCount = widthAxisCount > 2 ? widthAxisCount : 2;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          _officeData['design_office'],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
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
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
            child: Center(
              child: Text(
                '${officeList.length}개의 프로젝트가 등록되었습니다.',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: MasonryGridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                controller: _scrollController,
                itemCount: officeList.length,
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
                              arguments: officeList[index],
                            );
                          },
                          child: ExtendedImage.network(
                            officeList[index]['image_link'],
                            fit: BoxFit.cover,
                            cache: true,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              accountName: Center(
                child: Row(
                  children: [
                    Text(
                      _officeData['design_office'],
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    //북마크 버튼
                    Obx(
                      () => Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: IconButton(
                              onPressed: () {
                                List result = [];
                                result.addAll(controller.favorite.keys);
                                if (result.contains(_officeData['office_id'])) {
                                  controller.favorite
                                      .remove(_officeData['office_id']);
                                  Hive.box('Favorite')
                                      .put('Favorite', controller.favorite);
                                } else {
                                  controller
                                          .favorite[_officeData['office_id']] =
                                      _officeData['ic_link'];
                                  Hive.box('Favorite')
                                      .put('Favorite', controller.favorite);
                                }
                                controller.keyList.clear();
                                controller.keyList
                                    .addAll(controller.favorite.keys);
                              },
                              icon: controller.favorite
                                      .toString()
                                      .contains(_officeData['office_id'])
                                  ? const Icon(Icons.star, color: Colors.red)
                                  : const Icon(
                                      Icons.star_border,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              accountEmail: null,
              currentAccountPicture: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        offset: const Offset(-1.0, -1.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExtendedImage.network(
                    _officeData['ic_link'],
                    cache: true,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.perm_identity),
              title: SizedBox(
                height: 20,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _officeData['office_boss'].length,
                      itemBuilder: (context, idx) {
                        return Text(idx > 0
                            ? ', ' + _officeData['office_boss'][idx]
                            : _officeData['office_boss'][idx]);
                      },
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    String _num = _officeData['phone_number'];
                    _num = _num.replaceAll(")", "");
                    _num = _num.replaceAll("-", "");
                    callNumber(_num);
                  },
                  child: Text(
                    _officeData['phone_number'],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    sendEmail();
                  },
                  child: Text(
                    _officeData['email'],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: WordBreakText(
                    office_addressList[_officeData['office_id']],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    launchURL(_officeData['homepage_link']);
                  },
                  child: Text(
                    _officeData['homepage_link'],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
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
