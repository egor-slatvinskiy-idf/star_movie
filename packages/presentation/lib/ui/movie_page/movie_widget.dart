import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_page/bloc/movie_bloc.dart';
import 'package:presentation/ui/movie_page/bloc/movie_list_tile.dart';
import 'package:presentation/ui/movie_page/movie_list_widget.dart';

class MovieWidget extends StatefulWidget {
  const MovieWidget({Key? key}) : super(key: key);

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
          length: 2,
          child: Scaffold(
            backgroundColor: ColorsApplication.colorTheme,
            appBar: AppBar(
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Star Movie',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                    top: 7,
                    right: 17,
                    left: 17,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorsApplication.colorBorder,
                    ),
                    color: ColorsApplication.colorTheme,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: TabBar(
                      onTap: (index) {
                        if (index == 0) {
                          bloc.loadMovieTrending();
                        } else if (index == 1) {
                          bloc.loadMovieComing();
                        }
                      },
                      indicator: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.play_circle),
                              SizedBox(width: 6.28),
                              Text(
                                'Now Showing',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(width: 6.28),
                              Text(
                                'Coming Soon',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              )
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
                      horizontal: 18,
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
