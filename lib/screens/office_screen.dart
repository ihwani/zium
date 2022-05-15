import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:word_break_text/word_break_text.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(
      Controller(),
    );
    getSearch(controller.postList, Get.arguments);

    int widthAxisCount = size.width ~/ 300;
    int _axiisCount = widthAxisCount > 2 ? widthAxisCount : 2;

    String _argumentsData = Get.arguments;

    void _sendEmail() async {
      final Email email = Email(
        subject: '[설계 문의]',
        recipients: [foundList[0]['email']],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (error) {
        return showDialog(
          context: context,
          builder: (context) => Dialog(
            child: SizedBox(
              height: 240,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          '죄송합니다.\n\n기본 메일 앱을 사용할 수 없기 때문에\n앱에서 바로 문의를 전송하기가\n어려운 상황입니다.\n\n불편을 드려 죄송합니다.',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('확인'),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          foundList[0]['design_office'],
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
              child: Text('${foundList.length}개의 프로젝트가 등록되었습니다.'),
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: MasonryGridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: foundList.length,
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
                            Get.toNamed('/select', arguments: foundList[index]);
                          },
                          child: ExtendedImage.network(
                            foundList[index]['image_link'],
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
                      foundList[0]['design_office'],
                      style: const TextStyle(fontSize: 20),
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
                                if (result.contains(_argumentsData)) {
                                  controller.favorite.remove(_argumentsData);
                                  Hive.box('Favorite')
                                      .put('Favorite', controller.favorite);
                                } else {
                                  controller.favorite[_argumentsData] =
                                      foundList[0]['ic_link'];
                                  Hive.box('Favorite')
                                      .put('Favorite', controller.favorite);
                                }
                                controller.keyList.clear();
                                controller.keyList
                                    .addAll(controller.favorite.keys);
                              },
                              icon: controller.favorite
                                      .toString()
                                      .contains(_argumentsData)
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
                    foundList[0]['ic_link'],
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
                      itemCount: foundList[0]['office_boss'].length,
                      itemBuilder: (context, idx) {
                        return Text(idx > 0
                            ? ', ' + foundList[0]['office_boss'][idx]
                            : foundList[0]['office_boss'][idx]);
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
                    String _num = foundList[0]['phone_number'];
                    _num = _num.replaceAll(")", "");
                    _num = _num.replaceAll("-", "");
                    callNumber(_num);
                  },
                  child: Text(
                    foundList[0]['phone_number'],
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
                    _sendEmail();
                  },
                  child: Text(
                    foundList[0]['email'],
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
                    office_addressList[foundList[0]['office_id']],
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
                    launchURL(foundList[0]['homepage_link']);
                  },
                  child: Text(
                    foundList[0]['homepage_link'],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
