import 'package:get/get.dart';
import 'package:zium/screens/bookmark_screen.dart';
import 'package:zium/screens/feed_screen.dart';
import 'package:zium/screens/search_screen.dart';
import 'package:zium/screens/support_screen.dart';

class Controller extends GetxController {
  RxInt currentIndex = 0.obs;
  final pageList = [
    const FeedScreen(),
    const SearchScreen(),
    const BookmarkScreen(),
    const SupportScreen(),
  ].obs;
  RxList bookMark = [].obs;
  RxMap favorite = {}.obs;
  RxList postList = [].obs;
  RxList keyList = [].obs;
  RxList keywordList = [].obs;

//검색함수-2
  runFilter(String enteredKeyword, l, k) {
    List searchList = l;
    if (enteredKeyword.isEmpty) {
      k.clear();
    } else {
      k = searchList
          .where(
            (element) => element.toString().contains(enteredKeyword),
          )
          .toList();
      k.shuffle();
      update();
    }
  }
}
