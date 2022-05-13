import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

List foundList = [];
List keywordList = [];

Future<void> launchURL(String url) async {
  // ignore: deprecated_member_use
  await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
  );
}

//새로고침
Future onRefresh(c) async {
  c.shuffle();
  await Future.delayed(const Duration(milliseconds: 500));
}

//전화걸기
// ignore: avoid_types_as_parameter_names
Future callNumber(num) async {
  final number = num;
  // ignore: unused_local_variable
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}

//내부저장소 로드
getSaveData(a, b) {
  Hive.box(a).get(a).runtimeType == Null
      ? b.clear()
      : b.addAll(Hive.box(a).get(a));
  b.runtimeType == List ? b.shuffle() : null;
}

getSearch(c, s) {
  foundList = c
      .where(
        (element) => element.toString().contains(s),
      )
      .toList();
  foundList.shuffle();
}
