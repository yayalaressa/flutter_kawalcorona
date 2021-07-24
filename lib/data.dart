import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class DataKawalCorona {
  static Future<dynamic> getDataKawalCorona() async {
    //fetch data from api

    var url = Uri.https('api.kawalcorona.com', '/indonesia/provinsi/');

    // Await the http get response, then decode the json-formatted response.
    var response = await get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from kawalcorona.com');
    }
  }
}
