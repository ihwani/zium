import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zium/getx/getx_controller.dart';
import 'package:zium/util/util.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(Controller());
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      foundList.clear();
    } else {
      foundList = controller.postList
          .where(
            (element) => element.toString().contains(
                  enteredKeyword,
                ),
          )
          .toList();
    }

    setState(
      () {
        foundList.shuffle();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
      body: RefreshIndicator(
        onRefresh: () => onRefresh(foundList),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 1,
            runSpacing: 1,
            children: List.generate(
              foundList.length,
              (index) {
                return SizedBox(
                  width: (size.width - 3) / 3,
                  height: (size.width - 3) / 3,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/select', arguments: foundList[index]);
                    },
                    child: SizedBox(
                      child: CachedNetworkImage(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: foundList[index]['image_link'],
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
