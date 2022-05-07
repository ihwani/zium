import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 20,
              ),
              TextButton(
                  onPressed: () {
                    launchURL('http://thezium.co.kr');
                  },
                  child: const Text(
                    'http://thezium.co.kr',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            '문의 및 피드백',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.email,
                size: 16,
              ),
              Text('E-mail: thezium@icloud.com', style: TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(
            height: 8,
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
                                  child: const Text("Cancel")),
                              const SizedBox(
                                width: 30,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Hive.box('SaveData').clear();
                                    controller.bookMark.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              //   AlertDialog(
              //     title: const Text("북마크 전체 삭제"),
              //     content: const Text("북마크를 전부 삭제하겠습니까?"),
              //     actions: [
              //       TextButton(
              //           onPressed: () {
              //             Hive.box('SaveData').clear();
              //             controller.bookMark.clear();
              //           },
              //           child: const Text("Ok")),
              //       TextButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //           child: const Text("Cancel"))
              //     ],
              //   );
              // },
              child: const Text('북마크 전체 삭제'))
        ],
      ),
    );
  }
}
