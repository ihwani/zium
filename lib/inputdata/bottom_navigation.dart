import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    return Obx(
      () => CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Colors.black,
        onTap: (int index) {
          controller.currentIndex.value = index;
        },
        currentIndex: controller.currentIndex.value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_outlined),
            activeIcon: Icon(Icons.feedback),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}
