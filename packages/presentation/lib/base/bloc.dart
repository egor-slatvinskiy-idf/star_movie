import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/navigation/app_navigator.dart';

abstract class Bloc<D> {
  Stream<TileWrapper<D>> get dataStream;

  void initState();
}

abstract class BlocImpl<D> implements Bloc<D> {
  final _data = StreamController<TileWrapper<D>>();
  var _blocTile = TileWrapper<D>();

  @protected
  final appNavigator = GetIt.instance.get<AppNavigator>();

  @override
  Stream<TileWrapper<D>> get dataStream => _data.stream;

  @protected
  void handleData({D? tile,}) {
    _blocTile = _blocTile.copyWith(data: tile);
    _data.add(_blocTile);
  }

  @override
  void initState() {}
}