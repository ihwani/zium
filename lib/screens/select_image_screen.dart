import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/util/util.dart';

class SelectImageScreen extends StatelessWidget {
  const SelectImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _argumentsData = Get.arguments["select_image"];

    return SafeArea(
      child: Stack(children: [
        Center(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              maxScale: 2,
              child: Container(
                width: context.width,
                height: context.height,
                padding: const EdgeInsets.all(16),
                child: ExtendedImage.network(
                  _argumentsData['image_link'],
                  cache: true,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: OutlinedButton(
              onPressed: () {
                launchURL(_argumentsData['project_link']);
              },
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '상세페이지로 이동하기',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.open_in_new,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.pinch,
              color: Colors.white70,
            ),
          ),
        ),
      ]),
    );
  }
}
