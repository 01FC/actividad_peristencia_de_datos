import 'package:flutter/material.dart';

import 'home/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'persistencia',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Persistencia de datos"),
        ),
        body: Home(),
      ),
    );
  }
}
