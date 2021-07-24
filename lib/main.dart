import 'package:flutter/material.dart';
import 'package:kawal_corona/color.dart';
import 'package:kawal_corona/data.dart';

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
        primarySwatch: ColorPalette.palette1,
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

  @override
  void initState() {
    super.initState();
    listDataKawalCorona = DataKawalCorona.getDataKawalCorona();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<dynamic>(
          future: listDataKawalCorona,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  // ignore: unnecessary_null_comparison
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    final positif =
                        "${snapshot.data[i]['attributes']['Kasus_Posi']}";
                    final sembuh =
                        "${snapshot.data[i]['attributes']['Kasus_Semb']}";
                    return Card(
                      child: ListTile(
                          tileColor: ColorPalette.palette3,
                          title: Text(
                            "${snapshot.data[i]['attributes']['Provinsi']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: "Positif: "),
                                TextSpan(
                                  // ignore: unnecessary_brace_in_string_interps
                                  text: "${positif}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' | ',
                                ),
                                TextSpan(
                                  text: 'Sembuh: ',
                                ),
                                TextSpan(
                                  // ignore: unnecessary_brace_in_string_interps
                                  text: '${sembuh}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
