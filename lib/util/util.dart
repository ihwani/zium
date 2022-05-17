import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

List keywordList = [];
List officeList = [];
List tagList = [];
// ignore: non_constant_identifier_names
Map office_addressList = {};

String tagName = "";

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

//검색함수
getSearch(l, c, s) {
  l = c
      .where(
        (element) => element.toString().contains(s.toString()),
      )
      .toList();
}

//이메일 보내기
void sendEmail() async {
  final Email email = Email(
    subject: '[설계 문의]',
    recipients: [officeList[0]['email']],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    (BuildContext context) {
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
    };
  }
}
