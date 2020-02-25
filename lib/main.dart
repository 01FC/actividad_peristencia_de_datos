import 'package:flutter/material.dart';

import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'persistencia',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Persistencia de datos"),
        ),
        body: Home(
          scaffoldkey: _scaffoldKey,
        ),
      ),
    );
  }
}
