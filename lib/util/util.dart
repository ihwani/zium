import 'package:url_launcher/url_launcher.dart';

List<Map> postList = [];
List<Map> foundList = [];

Future<void> launchURL(String url) async {
  await launch(
    url,
    forceSafariVC: true,
    forceWebView: true,
  );
}
