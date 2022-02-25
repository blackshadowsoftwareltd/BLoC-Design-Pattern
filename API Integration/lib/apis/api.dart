// ignore: unused_import
import 'dart:convert';

import 'package:api_freezed/models/model.dart';
import 'package:http/http.dart' as http;

class GammerApi {
  static Future<List<GamerModel>?> getGamerData() async {
    var request = http.Request(
        'GET', Uri.parse('https://www.gamerpower.com/api/giveaways'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      // print(body);
      return gamerModelFromJson(body);
    } else {
      return null;
    }
  }
}
