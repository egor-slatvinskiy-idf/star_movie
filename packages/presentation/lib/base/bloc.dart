import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/navigation/base_arguments.dart';

abstract class Bloc<T extends BaseArguments, D> {
  Stream<TileWrapper<D>> get dataStream;

  void initState();

  void initArgs(T args);
}

abstract class BlocImpl<T extends BaseArguments, D> implements Bloc<T, D> {
  final _data = StreamController<TileWrapper<D>>();
  var _blocTile = TileWrapper<D>();

  @protected
  final appNavigator = GetIt.instance.get<AppNavigator>();

  @override
  Stream<TileWrapper<D>> get dataStream => _data.stream;

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
}
