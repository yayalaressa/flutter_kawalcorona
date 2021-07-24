import 'package:flutter/material.dart';
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
                    return Card(
                      child: ListTile(
                        title: Text(
                          "${snapshot.data[i]['attributes']['Provinsi']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "Positif: ${snapshot.data[i]['attributes']['Kasus_Posi']} | Sembuh: ${snapshot.data[i]['attributes']['Kasus_Semb']}"),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
