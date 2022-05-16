import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/inputdata/bottom_navigation.dart';
import 'package:zium/screens/bookmark_screen.dart';
import 'package:zium/screens/feed_screen.dart';
import 'package:zium/screens/office_screen.dart';
import 'package:zium/screens/search_screen.dart';
import 'package:zium/screens/select_feed_screen.dart';
import 'package:zium/screens/select_image_screen.dart';
import 'package:zium/screens/support_screen.dart';
import 'package:get/get.dart';
import 'package:zium/screens/tag_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zium/util/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FeedScreen()),
        GetPage(name: '/select', page: () => const SelectFeedScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/support', page: () => const SupportScreen()),
        GetPage(name: '/office', page: () => OfficeScreen()),
        GetPage(name: '/tag', page: () => TagScreen()),
        GetPage(name: '/bookmark', page: () => const BookmarkScreen()),
        GetPage(name: '/select_image', page: () => const SelectImageScreen()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Zium',
      home: MyApp(),
    ),
  );
}

Future initialization(BuildContext? context) async {
  await Hive.initFlutter();
  await Hive.openBox('BookMark');
  await Hive.openBox('Favorite');
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final controller = Get.put(
    Controller(),
  );

//서버db 로드
  getDataList(String u, List l) async {
    var _result = await http.get(
      Uri.parse(u),
    );
    List _results = jsonDecode(_result.body);
    l.addAll(_results);
    l.shuffle();
  }

//서버db 로드(주소)
  getDataMap(String u, Map m) async {
    var _result = await http.get(
      Uri.parse(u),
    );
    Map _results = jsonDecode(_result.body);
    m.addAll(_results);
  }

  @override
  Widget build(BuildContext context) {
    getDataList(
        'https://raw.githubusercontent.com/ihwani/zium_database/main/zium_database.json',
        controller.postList);
    getDataMap(
        'https://raw.githubusercontent.com/ihwani/zium_database/main/zium_office_address.json',
        office_addressList);
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Get.toNamed(
                  '/support',
                );
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => controller.pageList[controller.currentIndex.value],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
