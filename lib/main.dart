import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zium/screens/feed_screen.dart';
import 'package:zium/screens/office_screen.dart';
import 'package:zium/screens/search_screen.dart';
import 'package:zium/screens/support_screen.dart';
import 'package:get/get.dart';
import 'package:zium/screens/tag_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FeedScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/support', page: () => const SupportScreen()),
        GetPage(name: '/office', page: () => const OfficeScreen()),
        GetPage(name: '/tag', page: () => const TagScreen()),
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
  int _currentIndex = 0;
  final List<Widget> pageList = [
    const FeedScreen(),
    const SearchScreen(),
    const SupportScreen()
  ];

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
      body: pageList[_currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_outlined),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}
