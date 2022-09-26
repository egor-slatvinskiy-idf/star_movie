import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
import 'package:presentation/generated/l10n.dart';

const _emptyString = '';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<StatefulWidget, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      color: ColorsApplication.colorTheme,
      theme: ThemeData(
        canvasColor: ColorsApplication.colorTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorsApplication.colorTheme,
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
                            color: ColorsApplication.colorBorder,
                            width: Dimens.width1,
                          ),
                        ),
                      ),
                      child: BottomNavigationBar(
                        currentIndex: appData.selectedTab,
                        selectedFontSize: Dimens.size12,
                        type: BottomNavigationBarType.fixed,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.movieReel),
                            label: _emptyString,
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.movieReel,
                              color: ColorsApplication.colorSelectedItem,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.eventTicket),
                            label: _emptyString,
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.eventTicket,
                              color: ColorsApplication.colorSelectedItem,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.alarm),
                            label: _emptyString,
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.alarm,
                              color: ColorsApplication.colorSelectedItem,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImagesUtils.single),
                            label: _emptyString,
                            activeIcon: SvgPicture.asset(
                              ImagesUtils.single,
                              color: ColorsApplication.colorSelectedItem,
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
