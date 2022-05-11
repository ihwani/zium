import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:word_break_text/word_break_text.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      Controller(),
    );
    getSearch(controller.postList, Get.arguments);

    var size = MediaQuery.of(context).size;

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 1,
                runSpacing: 1,
                children: List.generate(
                  foundList.length,
                  (index) {
                    return SizedBox(
                      width: (size.width - 2) / 2,
                      height: (size.width - 2) / 2,
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
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30))),
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
                                if (result.contains(Get.arguments)) {
                                  controller.favorite.remove(Get.arguments);
                                  Hive.box('Favorite')
                                      .put('Favorite', controller.favorite);
                                } else {
                                  controller.favorite[Get.arguments] =
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
                                      .contains(Get.arguments)
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
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: CachedNetworkImage(
                  imageUrl: foundList[0]['ic_link'],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    foundList[0]['office_address'],
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
