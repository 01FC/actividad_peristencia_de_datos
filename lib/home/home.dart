import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(LoadConfigsEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: inicializar aqui los valores que se cargan en el BLoC
          // como solo observa los estados 1 vez, aqui se puede hacer
        },
        builder: (context, state) {
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
        // TODO: agregar List tile con Title = text y trailing = Switch
        Divider(),
        // Checkbox
        // TODO: agregar List tile con Title = text y trailing = Checkbox
        Divider(),
        // Slider
        Text("Slider", textAlign: TextAlign.center),
        // TODO: agregar slider

        Divider(),
        MaterialButton(
          child: Text("Guardar"),
          onPressed: () {
            //  TODO: Agregar evento para guardar
          },
        ),
      ],
    );
  }
}
