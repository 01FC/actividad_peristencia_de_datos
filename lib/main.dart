import 'package:flutter/material.dart';

import 'home/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  // inicializar antes de crear app
  WidgetsFlutterBinding.ensureInitialized();
  // acceso al local storage
  final _localStorage = await path_provider.getApplicationDocumentsDirectory();
  // inicializar hive
  Hive.init(_localStorage.path);
  // abrir una caja
  await Hive.openBox("configs");
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
