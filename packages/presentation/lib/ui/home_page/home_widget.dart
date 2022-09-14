import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/Library/images_utils/images_utils.dart';
import 'package:presentation/app_colors/app_colors.dart';
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
      backgroundColor: AppColors.colorTheme,
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.colorBorder,
              width: 1.0,
            ),
          ),
          color: Colors.white,
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.colorStars,
          currentIndex: _selectedTab,
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: [
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
          // fixedColor: Colors.white,
          onTap: onSelectedTab,
        ),
      ),
    );
  }
}
