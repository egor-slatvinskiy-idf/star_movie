import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_page/movie_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  static const _routeName = '/HomeWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const HomeWidget(),
        showSlideAnim: true,
      );

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedTab = 0;

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(
      () {
        _selectedTab = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 27, 43, 1),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const MovieWidget(),
          Container(),
          Container(),
          Container(),
          // Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(15, 27, 43, 1),
        currentIndex: _selectedTab,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.radar,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.no_accounts,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_filter_rounded,
            ),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
        fixedColor: Colors.white,
        onTap: onSelectedTab,
      ),
    );
  }
}
