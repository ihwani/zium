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
import 'package:zium/source_data/total_data.dart';
import 'package:zium/util/util.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FeedScreen()),
        GetPage(name: '/select', page: () => const SelectFeedScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/support', page: () => const SupportScreen()),
        GetPage(name: '/office', page: () => OfficeScreen()),
        GetPage(name: '/tag', page: () => const TagScreen()),
        GetPage(name: '/bookmark', page: () => BookmarkScreen()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Zium',
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    postList = BuildingData;
    postList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
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
