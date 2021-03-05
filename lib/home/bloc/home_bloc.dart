import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // referencia a la box
  Box _configBox = Hive.box("configs");
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadConfigsEvent) {
      // verificar si existen datos
      // cargar datos
      Map<String, dynamic> _configs = {
        "drop": _configBox.get("drop"),
        "switch": _configBox.get("switch", defaultValue: false),
        "checkbox": _configBox.get("checkbox", defaultValue: false),
        "slider": _configBox.get("slider", defaultValue: 0),
      };
      yield LoadedConfigsState(configs: _configs);
    } else if (event is LoadedConfigsEvent) {
      yield DoneState();
    } else if (event is SaveConfigsEvent) {
      try {
        // guardar datos
        _configBox.put("drop", event.configs["drop"]);
        _configBox.put("switch", event.configs["switch"]);
        _configBox.put("checkbox", event.configs["checkbox"] ?? false);
        _configBox.put("slider", event.configs["slider"]);

        yield DoneState();
      } catch (ex) {
        // error al guardar
        print(ex.toString());
        yield ErrorState(error: "Error al guardar");
      }
    }
  }
}
