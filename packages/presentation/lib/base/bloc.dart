import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/base/dialog_event.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/navigation/base_arguments.dart';

abstract class Bloc<T extends BaseArguments, D> {
  Stream<TileWrapper<D>> get dataStream;

  Stream<DialogEvent> get eventStream;

  void initState();

  void initArgs(T args);

  void showAlert({dynamic event});
}

abstract class BlocImpl<T extends BaseArguments, D> implements Bloc<T, D> {
  final _data = StreamController<TileWrapper<D>>();
  final _eventStream = StreamController<DialogEvent>();
  var _blocTile = TileWrapper<D>();

  @protected
  final appNavigator = GetIt.instance.get<AppNavigator>();

  @override
  Stream<TileWrapper<D>> get dataStream => _data.stream;

  @override
  Stream<DialogEvent> get eventStream => _eventStream.stream;

  @protected
  void handleData({
    D? tile,
    bool? isLoading,
  }) {
    _blocTile = _blocTile.copyWith(
      data: tile,
      isLoading: isLoading,
    );
    _data.add(_blocTile);
  }

  @override
  void initState() {}

  @override
  void initArgs(T arguments) {}

  @override
  void showAlert({dynamic event}) {
    _eventStream.add(event);
  }
}
