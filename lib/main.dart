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
      home: KawalCoronaApp(title: 'Flutter Kawal Corona'),
    );
  }
}

class KawalCoronaApp extends StatefulWidget {
  const KawalCoronaApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  KawalCoronaState createState() => KawalCoronaState();
}

class KawalCoronaState extends State<KawalCoronaApp> {
  dynamic listDataKawalCorona;

  @override
  void initState() {
    super.initState();
    listDataKawalCorona = DataKawalCorona.getDataKawalCorona();
  }

  Future<void> refreshDataKawalCorona() async {
    setState(() {
      listDataKawalCorona = DataKawalCorona.getDataKawalCorona();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () => refreshDataKawalCorona(),
      child: _loadDataKawalCorona(),
    );
  }

  Widget _loadDataKawalCorona() {
    return FutureBuilder<dynamic>(
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
