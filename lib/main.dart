import 'package:flutter/material.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/inputdata/bottom_navigation.dart';
import 'package:zium/screens/bookmark_screen.dart';
import 'package:zium/screens/feed_screen.dart';
import 'package:zium/screens/office_screen.dart';
import 'package:zium/screens/search_screen.dart';
import 'package:zium/screens/select_feed_screen.dart';
import 'package:zium/screens/support_screen.dart';
import 'package:get/get.dart';
import 'package:zium/screens/tag_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('SaveData');
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FeedScreen()),
        GetPage(name: '/select', page: () => const SelectFeedScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/support', page: () => const SupportScreen()),
        GetPage(name: '/office', page: () => const OfficeScreen()),
        GetPage(name: '/tag', page: () => const TagScreen()),
        GetPage(name: '/bookmark', page: () => const BookmarkScreen()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Zium',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final controller = Get.put(Controller());

  getData() async {
    var result = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/ihwani/zium_database/main/zium_database.json'));
    List results = jsonDecode(result.body);
    controller.postList.addAll(results);
    controller.postList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    Hive.box('SaveData').get('BookMark').runtimeType == Null
        ? null
        : controller.bookMark.addAll(Hive.box('SaveData').get('BookMark'));
    controller.bookMark.shuffle();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Zium',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
        ),
        body: Obx(() => controller.pageList[controller.currentIndex.value]),
        bottomNavigationBar: const BottomNavigation());
  }
}
