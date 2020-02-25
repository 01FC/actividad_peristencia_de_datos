import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  Home({Key key, @required this.scaffoldkey}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Drop down list variables
  String _dropSelectedValue = "dos";
  static const List<String> _options = ["uno", "dos", "tres", "cuatro"];
  final List<DropdownMenuItem<String>> _itemOptionsList = _options
      .map(
        (val) => DropdownMenuItem<String>(
          value: val,
          child: Text("$val"),
        ),
      )
      .toList();
  // Switch variables
  bool _switchValue = false;
  // Checkbox variables
  bool _checkValue = false;

  @override
  Widget build(BuildContext context) {
    return buildListView(context);
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Drop down list
        ListTile(
          title: Text("Dropdown"),
          trailing: DropdownButton(
            items: _itemOptionsList,
            value: _dropSelectedValue,
            onChanged: (newValue) {
              setState(() {
                _dropSelectedValue = newValue;
              });
            },
          ),
        ),
        Divider(),
        // Switch
        ListTile(
          title: Text("Switch"),
          trailing: Switch(
            value: _switchValue,
            onChanged: (newValue) {
              setState(() {
                _switchValue = newValue;
              });
            },
          ),
        ),
        Divider(),
        // Checkbox
        ListTile(
          title: Text("Checkbox"),
          trailing: Checkbox(
            value: _checkValue,
            onChanged: (newValue) {
              setState(() {
                _checkValue = newValue;
              });
            },
          ),
        ),
        Divider(),
        // Slider
        Text("Slider", textAlign: TextAlign.center),

        Divider(),
        FlatButton(
          child: Text("Guardar"),
          onPressed: () {
            widget.scaffoldkey.currentState
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Guardado...")),
              );
          },
        ),
      ],
    );
  }
}
