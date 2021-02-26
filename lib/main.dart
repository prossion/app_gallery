import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading;
  List data;
  void initState() {
    loading = true;
    super.initState();
    getData();
  }

  Future<String> getData() async {
    var onlineData = await http.get(
        'https://api.unsplash.com/search/photos?per_page=40&client_id=JHtiz-7X3AO66_2tH9pBkMEDIQcjnF3qOS3MB1Ifjho&query=nature');
    var jData = json.decode(onlineData.body);
    setState(() {
      loading = false;
      data = jData['results'];
    });
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(title: Text("Wallpapers")),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.black,
                                ),
                                backgroundColor: Colors.black,
                                body: Center(
                                  child: Image.network(
                                    data[index]['urls']['regular'],
                                  ),
                                ));
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 500.0,
                      height: 500.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 18.0, left: 10.0, right: 10.0),
                        child: Image.network(
                          data[index]['urls']['small'],
                          fit: BoxFit.cover,
                          height: 500.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Stack(
                      children: <Widget>[
                        Text(
                          data[index]['user']['name'],
                          style: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

// color: Colors.white,
// fontSize: 18,
// data[index]['user']['name'],
