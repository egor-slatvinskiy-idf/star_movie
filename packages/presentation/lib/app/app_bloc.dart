import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/navigation/base_page.dart';

abstract class AppBloc extends Bloc {
  factory AppBloc() => _AppBloc();

  void handleRemoveRouteSettings(RouteSettings value);

  void onSelectedTab(int index);
}

class _AppBloc extends BlocImpl implements AppBloc {
  final _appData = AppData.init();
  int? selectedTab;

  @override
  void initState() {
    super.initState();
    _initNavHandler();
    _updateData();
  }

  @override
  void handleRemoveRouteSettings(RouteSettings value) {
    _appData.pages.remove(value);
    _updateData();
  }

  void _initNavHandler() {
    appNavigator.init(
      push: _push,
      popOldAndPush: _popOldAndPush,
      popAllAndPush: _popAllAndPush,
      popAndPush: _popAndPush,
      pushPages: _pushPages,
      popAllAndPushPages: _popAllAndPushPages,
      pop: _pop,
      maybePop: _maybePop,
      popUntil: _popUntil,
      currentPage: _currentPage,
    );
  }

  void _push(BasePage page) {
    _appData.pages.add(page);
    _updateData();
  }

  void _popAllAndPush(BasePage page) {
    _appData.pages.clear();
    _push(page);
  }

  void _popOldAndPush(BasePage page) {
    final oldIndex = _appData.pages.indexWhere(
      (element) => element.name == page.name,
    );
    if (oldIndex != -1) {
      _appData.pages.removeAt(oldIndex);
    }
    _push(page);
  }

  void _popAndPush(BasePage page) {
    _appData.pages.removeLast();
    _push(page);
  }

  void _pushPages(List<BasePage> pages) {
    pages.forEach(_appData.pages.add);
    _updateData();
  }

  void _popAllAndPushPages(List<BasePage> pages) {
    _appData.pages.clear();
    pages.forEach(_appData.pages.add);
    _updateData();
  }

  void _pop() {
    _appData.pages.removeLast();
    _updateData();
  }

  void _maybePop() {
    if (_appData.pages.length > 1) {
      _pop();
    }
  }

  void _popUntil(BasePage page) {
    final start = _appData.pages.indexWhere((e) => e.name == page.name) + 1;
    final end = _appData.pages.length;
    _appData.pages.removeRange(start, end);
    _updateData();
  }

  BasePage? _currentPage() => _appData.pages.lastOrNull;

  void _updateData() {
    _appData.showBottomBar = _currentPage()!.showBottomBar;
    super.handleData(tile: _appData);
  }

  @override
  void onSelectedTab(int index) {
    if (selectedTab == index) return;
    selectedTab = index;
    super.handleData(
      tile: _appData.copyWith(selectedTab: index),
    );
  }
}
