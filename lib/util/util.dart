import 'package:url_launcher/url_launcher.dart';

List foundList = [];

Future<void> launchURL(String url) async {
  await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
  );
}

Future onRefresh(c) async {
  c.shuffle();
  await Future.delayed(const Duration(milliseconds: 500));
}
