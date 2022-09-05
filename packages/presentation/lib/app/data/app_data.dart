import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/splash_screen/splash_widget.dart';

class AppData {
  final List<BasePage> pages;

  AppData(
    this.pages,
  );

  factory AppData.init() {
    final pages = List<BasePage>.from(
      [
        SplashWidget.page(),
      ],
    );
    return AppData(pages);
  }
}
