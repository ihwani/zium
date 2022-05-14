import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    void _sendEmail() async {
      final Email email = Email(
        subject: '[지음 문의 및 피드백]',
        recipients: ['thezium@icloud.com'],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (error) {
        return showDialog(
          context: context,
          builder: (context) => Dialog(
            child: SizedBox(
              height: 300,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          '죄송합니다.\n\n기본 메일 앱을 사용할 수 없기 때문에\n앱에서 바로 문의를 전송하기가\n어려운 상황입니다.\n\n아래 이메일로 연락주시면 친절하게\n답변해드릴게요 :)\n\n\nthezium@icloud.com',
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
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ci_zium.png',
              height: 300,
            ),
            const Text(
              '홈페이지',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 30,
              width: 200,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                ),
                onPressed: () {
                  launchURL('http://thezium.co.kr');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.home,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'http://thezium.co.kr',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              '문의 및 피드백',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 30,
              width: 200,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                ),
                onPressed: () {
                  _sendEmail();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.mail,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'thezium@icloud.com',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(
              () => Text(
                "${controller.postList.length}개의 DB가 로드되었습니다.",
                style: TextStyle(color: Colors.grey[300]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
