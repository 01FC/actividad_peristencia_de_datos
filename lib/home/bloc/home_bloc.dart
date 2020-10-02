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
      try {
        // verificar si existen datos
        if (_configBox.values.isEmpty) throw Exception();
        // cargar datos
        Map<String, dynamic> _configs = {
          "drop": _configBox.get("drop"),
          "switch": _configBox.get("switch"),
          "checkbox": _configBox.get("checkbox") ?? false,
          "slider": _configBox.get("slider"),
        };
        yield LoadedConfigsState(configs: _configs);
      } catch (ex) {
        // no hay datos
        print(ex.toString());
        yield ErrorState(error: "No hay datos guardados...");
      }
    } else if (event is LoadedConfigsEvent) {
      yield DoneState();
    } else if (event is SaveConfigsEvent) {
      try {
        // verificar si existen datos
        if (event.configs.values.first == null) throw Exception();
        // cargar datos
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
