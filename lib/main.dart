import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KawalCrona(title: 'Flutter Kawal Corona'),
    );
  }
}

class KawalCrona extends StatefulWidget {
  const KawalCrona({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _KawalCronaState createState() => _KawalCronaState();
}

class _KawalCronaState extends State<KawalCrona> {
  dynamic listDataKawalCorona;

  Future getDataKawalCorona() async {
    //fetch data from api

    var url = Uri.https('api.kawalcorona.com', '/indonesia/provinsi/');

    // Await the http get response, then decode the json-formatted response.
    var response = await get(url);
    if (response.statusCode == 200) {
      this.setState(() {
        listDataKawalCorona = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    this.getDataKawalCorona();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            // ignore: unnecessary_null_comparison
            itemCount:
                // ignore: unnecessary_null_comparison
                listDataKawalCorona == null ? 0 : listDataKawalCorona.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(
                    "${listDataKawalCorona[i]['attributes']['Provinsi']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Positif: ${listDataKawalCorona[i]['attributes']['Kasus_Posi']} | Sembuh: ${listDataKawalCorona[i]['attributes']['Kasus_Semb']}"),
                ),
              );
            }),
      ),
    );
  }
}
