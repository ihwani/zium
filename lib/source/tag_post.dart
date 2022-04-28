import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zium/source_data/total_data.dart';

class TagInputData extends StatefulWidget {
  const TagInputData({Key? key}) : super(key: key);

  @override
  State<TagInputData> createState() => _TagInputData();
}

class _TagInputData extends State<TagInputData> {
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw '웹 호출 실패 $url';
    }
  }

  final List<Map> _foundDatas = BuildingData.where(
    (element) => element.toString().contains(Get.arguments),
  ).toList();

  @override
  Widget build(BuildContext context) {
    List<Map> _randomList = _foundDatas;
    _randomList.shuffle();

    var size = MediaQuery.of(context).size;

    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            '#' + Get.arguments,
            style: const TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          spacing: 1,
          runSpacing: 1,
          children: List.generate(
            _foundDatas.length,
            (index) {
              return SizedBox(
                width: (size.width - 3) / 3,
                height: (size.width - 3) / 3,
                child: GestureDetector(
                  onTap: () {
                    _launchURL(_randomList[index]['project_link']);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      _randomList[index]['image_link'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
