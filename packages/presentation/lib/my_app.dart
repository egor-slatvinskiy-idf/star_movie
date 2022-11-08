import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/widgets/bottom_navigation_bar.dart';
import 'package:presentation/library/widgets/navigation_rail.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<StatefulWidget, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      useInheritedMediaQuery: true,
      builder: (context, child) {
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
              centerTitle: false,
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
                  body: Row(
                    children: [
                      Dimens.isWide(context) && appData.showBottomBar
                          ? NavigationRailWidget(
                              appData: appData,
                              bloc: bloc,
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: Navigator(
                          onPopPage: (Route<dynamic> route, dynamic result) {
                            bloc.handleRemoveRouteSettings(route.settings);
                            return route.didPop(result);
                          },
                          pages: appData.pages.toList(),
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar:
                      appData.showBottomBar && Dimens.isNarrow(context)
                          ? BottomNavigationBarWidget(
                              appData: appData,
                              bloc: bloc,
                            )
                          : const SizedBox.shrink(),
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
