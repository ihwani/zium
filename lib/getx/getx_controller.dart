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
    BookmarkScreen(),
    const SupportScreen(),
  ].obs;
  var bookMark = [].obs;
}