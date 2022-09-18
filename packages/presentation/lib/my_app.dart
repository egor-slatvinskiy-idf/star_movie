import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/library/images_utils/images_utils.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<StatefulWidget, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.colorTheme,
      theme: ThemeData(
        canvasColor: AppColors.colorTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.colorTheme,
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
              bottomNavigationBar: appData.showBottomBar
                  ? Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.colorBorder,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: BottomNavigationBar(
                        currentIndex: appData.selectedTab,
                        selectedFontSize: 12,
                        type: BottomNavigationBarType.fixed,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.movieReel),
                            label: '',
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.movieReel,
                              color: AppColors.colorSelectedItem,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.eventTicket),
                            label: '',
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.eventTicket,
                              color: AppColors.colorSelectedItem,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.alarm),
                            label: '',
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.alarm,
                              color: AppColors.colorSelectedItem,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.single),
                            label: '',
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.single,
                              color: AppColors.colorSelectedItem,
                            ),
                          ),
                        ],
                        onTap: bloc.onSelectedTab,
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
