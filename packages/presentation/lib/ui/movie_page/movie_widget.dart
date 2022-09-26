import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/style/text_style.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_page/bloc/movie_bloc.dart';
import 'package:presentation/ui/movie_page/bloc/movie_list_tile.dart';
import 'package:presentation/ui/movie_page/movie_list_widget.dart';

const _nowShowingIndex = 0;
const _comingSoonIndex = 1;
const _lengthController = 2;

class MovieWidget extends StatefulWidget {
  const MovieWidget({super.key});

  static const _routeName = '/MovieWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const MovieWidget(),
        showSlideAnim: true,
        showBottomBar: true,
      );

  @override
  State createState() => _MovieWidgetState();
}

class _MovieWidgetState extends BlocScreenState<MovieWidget, MovieBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TileWrapper<MovieListTile>>(
      stream: bloc.dataStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        final movieTile = data?.data;
        return DefaultTabController(
          length: _lengthController,
          child: Scaffold(
            backgroundColor: ColorsApplication.colorTheme,
            appBar: AppBar(
              elevation: Dimens.size0,
              title: Padding(
                padding: const EdgeInsets.only(
                  left: Dimens.padding12,
                ),
                child: Text(
                  S.of(context).starMovie,
                  style: sfProSemi24(
                    color: ColorsApplication.colorTitle,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: Dimens.padding12,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: Dimens.size24,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: Dimens.padding24,
                    top: Dimens.padding8,
                    right: Dimens.padding18,
                    left: Dimens.padding18,
                  ),
                  height: Dimens.height50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorsApplication.colorBorder,
                    ),
                    color: ColorsApplication.colorTheme,
                    borderRadius: BorderRadius.circular(
                      Dimens.border20,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Dimens.padding4,
                    ),
                    child: TabBar(
                      onTap: (index) {
                        if (index == _nowShowingIndex) {
                          bloc.loadMovieTrending();
                        } else if (index == _comingSoonIndex) {
                          bloc.loadMovieComing();
                        }
                      },
                      indicator: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          Dimens.border16,
                        ),
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_circle),
                              const SizedBox(width: Dimens.width6),
                              Text(
                                S.of(context).nowShowing,
                                style: sfProMed14(
                                  color: ColorsApplication.colorTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: Dimens.width6),
                              Text(
                                S.of(context).comingSoon,
                                style: sfProMed14(
                                  color: ColorsApplication.colorTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.padding18,
                    ),
                    child: TabBarView(
                      children: [
                        MovieListWidget(
                          data: data,
                          rowData: movieTile?.movieTrending,
                          bloc: bloc,
                        ),
                        MovieListWidget(
                          data: data,
                          rowData: movieTile?.movieComing,
                          bloc: bloc,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
