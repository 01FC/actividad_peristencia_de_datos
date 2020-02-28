import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/home/bloc/home_bloc.dart';

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

  double _sliderValue = 2.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            BlocProvider.of<HomeBloc>(context).add(LoadConfigsEvent());
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedConfigsState) {
            _dropSelectedValue = state.configs["drop"];
            _switchValue = state.configs["switch"];
            _checkValue = state.configs["check"];
            _sliderValue = state.configs["slider"];
            BlocProvider.of<HomeBloc>(context).add(LoadedConfigsEvent());
          }
          return buildListView(context);
        },
      ),
    );
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
        Slider(
          value: _sliderValue,
          min: 0,
          max: 10,
          divisions: 5,
          label: "${_sliderValue.round()}",
          onChanged: (newValue) {
            setState(() {
              _sliderValue = newValue;
            });
          },
        ),

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
