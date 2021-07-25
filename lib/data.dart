import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

// Source https://flutter.dev/docs/cookbook/networking/background-parsing
class DataKawalCorona {
  static Future<List<Corona>> getDataKawalCorona() async {
    //fetch data from api

    var url = Uri.https('api.kawalcorona.com', '/indonesia/provinsi/');

    // Await the http get response, then decode the json-formatted response.
    var response = await get(url);
    if (response.statusCode == 200) {
      return compute(parseCorona, response.body);
    } else {
      throw Exception('Failed to load data from kawalcorona.com');
    }
  }

  static List<Corona> parseCorona(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Corona>((json) => Corona.fromJson(json)).toList();
  }
}

class Corona {
  final Attributes attributes; // attributes class

  const Corona({
    required this.attributes,
  });

  factory Corona.fromJson(Map<String, dynamic> json) {
    return Corona(
      attributes: Attributes.fromJson(json['attributes']),
    );
  }
}

class Attributes {
  final int fid;
  final int kodeProvi;
  final String provinsi;
  final int kasusPosi;
  final int kasusSemb;
  final int kasusMeni;

  const Attributes(
      {required this.fid,
      required this.kodeProvi,
      required this.provinsi,
      required this.kasusPosi,
      required this.kasusSemb,
      required this.kasusMeni});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      fid: json['FID'],
      kodeProvi: json['Kode_Provi'],
      provinsi: json['Provinsi'],
      kasusPosi: json['Kasus_Posi'],
      kasusSemb: json['Kasus_Semb'],
      kasusMeni: json['Kasus_Meni'],
    );
  }
}
