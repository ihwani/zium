import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zium/source_data/total_data.dart';

class SearchInputData extends StatefulWidget {
  const SearchInputData({Key? key}) : super(key: key);

  @override
  State<SearchInputData> createState() => _SearchInputDataState();
}

class _SearchInputDataState extends State<SearchInputData> {
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

  final List<Map> _buildingDatas = BuildingData;
  List<Map> _foundDatas = [];

  void _runFilter(String enteredKeyword) {
    List<Map> results = [];
    if (enteredKeyword.isEmpty) {
      _foundDatas.clear();
    } else {
      results = _buildingDatas
          .where(
            (element) => element.toString().contains(
                  enteredKeyword,
                ),
          )
          .toList();
    }

    setState(
      () {
        _foundDatas = results;
      },
    );
  }

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
        title: TextField(
          onSubmitted: (value) => _runFilter(value),
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: '  Search',
            labelStyle: TextStyle(fontSize: 15),
            hintText: '  (사무소명, 건물용도, 지역)',
            hintStyle: TextStyle(color: Colors.black, fontSize: 15),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
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
