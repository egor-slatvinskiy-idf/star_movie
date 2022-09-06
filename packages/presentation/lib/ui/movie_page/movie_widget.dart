import 'package:flutter/material.dart';
import 'package:presentation/ui/movie_page/movie_coming_soon_widget.dart';
import 'package:presentation/ui/movie_page/movie_now_showing_widget.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(15, 27, 43, 1),
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
                left: 18,
              ),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(44, 63, 91, 1)),
                color: const Color.fromRGBO(15, 27, 43, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: TabBar(
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
            const Expanded(
              child: TabBarView(
                children: [
                  MovieNowShowingWidget(),
                  MovieComingSoonWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
