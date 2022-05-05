import 'package:url_launcher/url_launcher.dart';

List foundList = [];

Future<void> launchURL(String url) async {
  await launch(
    url,
    forceSafariVC: true,
    forceWebView: true,
  );
}
