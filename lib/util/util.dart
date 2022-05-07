import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  await launch(url,
      forceSafariVC: true, forceWebView: true, enableJavaScript: true);
}

Future onRefresh(c) async {
  c.shuffle();
  await Future.delayed(const Duration(milliseconds: 500));
}

List foundList = [];
