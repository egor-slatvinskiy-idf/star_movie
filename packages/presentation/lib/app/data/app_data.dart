import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/splash_screen/splash_widget.dart';

class AppData {
  final List<BasePage> pages;
  bool showBottomBar;
  final int selectedTab;

  AppData({
    required this.pages,
    required this.showBottomBar,
    required this.selectedTab,
  });

  factory AppData.init() {
    final pages = List<BasePage>.from(
      [
        SplashWidget.page(),
      ],
    );
    return AppData(
      pages: pages,
      showBottomBar: true,
      selectedTab: 0,
    );
  }

  AppData copyWith({
    List<BasePage>? pages,
    bool? showBottomBar,
    int? selectedTab,
  }) {
    return AppData(
      pages: pages ?? this.pages,
      showBottomBar: showBottomBar ?? this.showBottomBar,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
