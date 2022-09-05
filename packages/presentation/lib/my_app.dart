import 'package:flutter/material.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<StatefulWidget, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromRGBO(15, 27, 43, 1),
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(15, 27, 43, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(15, 27, 43, 1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
      ),
      home: StreamBuilder<TileWrapper>(
        stream: bloc.dataStream,
        builder: (context, result) {
          final blocData = result.data;
          final appData = blocData?.data;
          if (appData is AppData) {
            return Scaffold(
              body: Navigator(
                onPopPage: (Route<dynamic> route, dynamic result) {
                  bloc.handleRemoveRouteSettings(route.settings);
                  return route.didPop(result);
                },
                pages: appData.pages.toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
