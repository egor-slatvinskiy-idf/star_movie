import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/library/dimens/dimens.dart';

class CastUtils {
  const CastUtils._();

  static widthForCast(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return currentWidth < Dimens.size800
        ? Dimens.size350.w
        : currentWidth > Dimens.size800
        ? Dimens.size130.w
        : Dimens.size250;
  }
}