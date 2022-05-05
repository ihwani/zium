import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

List<Map> postList = [];
List<Map> foundList = [];

Future<void> launchURL(String url) async {
  await launch(
    url,
    forceSafariVC: true,
    forceWebView: true,
  );
}
