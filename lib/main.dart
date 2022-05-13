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
import 'package:flutter/services.dart';
import 'package:zium/util/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  await Hive.openBox('BookMark');
  await Hive.openBox('Favorite');
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

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final controller = Get.put(
    Controller(),
  );

//서버db 로드
  getData() async {
    var _result = await http.get(
      Uri.parse(
          'https://raw.githubusercontent.com/ihwani/zium_database/main/zium_database.json'),
    );
    List _results = jsonDecode(_result.body);
    controller.postList.addAll(_results);
    controller.postList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    getSaveData('BookMark', controller.bookMark);
    getSaveData('Favorite', controller.favorite);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white10,
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
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
