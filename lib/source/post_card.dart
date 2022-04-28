import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zium/source_data/total_data.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    List<String> _bookMark = [];
    List<Map> _randomList = BuildingData;
    _randomList.shuffle();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.builder(
        itemCount: _randomList.length,
        itemBuilder: ((context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ).copyWith(
                  right: 0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        _randomList[index]['ic_link'],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed("/office", arguments: _randomList[index]);
                          // _launchURL(_randomList[index]['homepage_link']);
                        },
                        child: Text(
                          _randomList[index]['design_office'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GestureDetector(
                  onTap: () {
                    _launchURL(_randomList[index]['project_link']);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Image.network(
                      _randomList[index]['image_link'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(children: [
                    const Icon(Icons.location_on),
                    Text(_randomList[index]['location'])
                  ]),
                ),
              ]),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(_randomList[index]['project_name']),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          if (_bookMark
                              .contains(_randomList[index]['project_id'])) {
                            _bookMark.remove(_randomList[index]['project_id']);
                          } else {
                            _bookMark.add(_randomList[index]['project_id']);
                          }
                          // ignore: avoid_print
                          print(_bookMark);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Dialog(
                                    child: SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    '준비중입니다.',
                                    textAlign: TextAlign.center,
                                  )),
                                ));
                              });
                        },
                        icon:
                            _bookMark.contains(_randomList[index]['project_id'])
                                ? const Icon(Icons.bookmark, color: Colors.red)
                                : const Icon(
                                    Icons.bookmark_border,
                                  ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _randomList[index]['tag'].length,
                    itemBuilder: (context, idx) {
                      return TextButton(
                          onPressed: () {
                            Get.toNamed('/tag',
                                arguments: _randomList[index]['tag'][idx]);
                          },
                          child: Text('# ' + _randomList[index]['tag'][idx]));
                      // return Text('#' + _randomList[index]['tag'][idx] + " ");
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        }),
      ),
    );
  }
}
