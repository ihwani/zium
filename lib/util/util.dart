import 'package:url_launcher/url_launcher.dart';

List<Map> postList = [];
List<Map> foundList = [];
List<Map> bookMarkList = [];

Future<void> launchURL(String url) async {
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
