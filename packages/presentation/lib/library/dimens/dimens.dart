import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimens {
  const Dimens._();

  ///size
  static const Size minWindowSize = Size(370, 700);
  static const double size021 = 0.21;
  static const double size01 = 0.1;
  static const double size0 = 0;
  static const double size1 = 1;
  static const double size2 = 2;
  static const double size4 = 4;
  static const double size6 = 6;
  static const double size8 = 8;
  static const double size10 = 10;
  static const double size12 = 12;
  static const double size14 = 14;
  static const double size16 = 16;
  static const double size18 = 18;
  static const double size20 = 20;
  static const double size22 = 22;
  static const double size24 = 24;
  static const double size26 = 26;
  static const double size28 = 28;
  static const double size30 = 30;
  static const double size32 = 32;
  static const double size34 = 34;
  static const double size36 = 36;
  static const double size38 = 38;
  static const double size40 = 40;
  static const double size42 = 42;
  static const double size44 = 44;
  static const double size46 = 46;
  static const double size48 = 48;
  static const double size50 = 50;
  static const double size70 = 70;
  static const double size96 = 96;
  static const double size100 = 100;
  static const double size130 = 130;
  static const double size150 = 150;
  static const double size166 = 166;
  static const double size218 = 218;
  static const double size250 = 250;
  static const double size300 = 300;
  static const double size350 = 350;
  static const double size400 = 400;
  static const double size500 = 500;
  static const double size600 = 600;
  static const double size800 = 800;
  static const double size1000 = 1000;
  static const double size1200 = 1200;
  static const double sizeInfinity = double.infinity;

  ///maxLines
  static const int maxLines1 = 1;
  static const int maxLines2 = 2;
  static const int maxLines3 = 3;
  static const int maxLines4 = 4;

  ///axisCountMovie
  static const int movieCount2 = 2;
  static const int movieCount3 = 3;
  static const int movieCount4 = 4;
  static const int movieCount5 = 5;
  static const int movieCount6 = 6;
  static const int movieCount7 = 7;

  ///MediaQuery methods
  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width > Dimens.size500;

  static bool isNarrow(BuildContext context) =>
      MediaQuery.of(context).size.width < Dimens.size500;

  static axisCountMovie(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return currentWidth < size400
        ? movieCount2
        : currentWidth < size600
            ? movieCount3
            : currentWidth < size800
                ? movieCount4
                : currentWidth < size1000
                    ? movieCount5
                    : currentWidth < size1200
                        ? movieCount6
                        : movieCount7;
  }

  static widthForCast(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return currentWidth < size800
        ? size350.w
        : currentWidth > size800
            ? size130.w
            : size250;
  }

  static widthForOverView(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return currentWidth < size800
        ? size350.w
        : currentWidth > size800
            ? size130.w
            : size250;
  }
}
