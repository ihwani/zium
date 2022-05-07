import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('죄송합니다.', style: TextStyle(fontSize: 16)),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        '기본 메일 앱을 사용할 수 없기 때문에',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '앱에서 바로 문의를 전송하기가',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '어려운 상황입니다.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '아래 이메일로 연락주시면',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '친절하게 답변해드릴게요 :)',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'thezium@icloud.com',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(height: 8),
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

    final controller = Get.put(Controller());
    return Center(
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
            height: 32,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: SizedBox(
                    height: 100,
                    width: 300,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "북마크를 전부 삭제하시겠습니까?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("취소")),
                            const SizedBox(
                              width: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                Hive.box('BookMark').delete('BookMark');
                                controller.bookMark.clear();
                                Navigator.pop(context);
                              },
                              child: const Text("확인"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Text('북마크 전체 삭제'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: SizedBox(
                    height: 100,
                    width: 300,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "즐겨찾기를 전부 삭제하시겠습니까?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("취소")),
                            const SizedBox(
                              width: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                Hive.box('Favorite').delete('Favorite');
                                controller.favorite.clear();
                                Navigator.pop(context);
                              },
                              child: const Text("확인"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Text('즐겨찾기 전체 삭제'),
          )
        ],
      ),
    );
  }
}
