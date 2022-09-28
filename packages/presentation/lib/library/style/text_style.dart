import 'package:flutter/material.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';

const _fontFamilySFProSemiBold = 'SF Pro Text Semibold';
const _fontFamilySFProMedium = 'SF Pro Text Medium';


class TextStyles {
  TextStyles._();

  static TextStyle sfProSemi24({
    Color color = ColorsApplication.colorTitle,
  }) =>
      TextStyle(
        color: color,
        fontSize: Dimens.size24,
        fontFamily: _fontFamilySFProSemiBold,
      );

  static TextStyle sfProSemi16({
    Color color = ColorsApplication.colorTitle,
  }) =>
      TextStyle(
        color: color,
        fontSize: Dimens.size16,
        fontFamily: _fontFamilySFProSemiBold,
      );

  static TextStyle sfProSemi30({
    Color color = ColorsApplication.colorTitle,
  }) =>
      TextStyle(
        color: color,
        fontSize: Dimens.size30,
        fontFamily: _fontFamilySFProSemiBold,
      );

  static TextStyle sfProMed14({
    Color color = ColorsApplication.colorTitle,
  }) =>
      TextStyle(
        color: color,
        fontSize: Dimens.size14,
        fontFamily: _fontFamilySFProMedium,
      );

  static TextStyle sfProMed18({
    Color color = ColorsApplication.colorTitle,
  }) =>
      TextStyle(
        color: color,
        fontSize: Dimens.size18,
        fontFamily: _fontFamilySFProMedium,
      );

  static TextStyle sfProMed12({
    Color color = ColorsApplication.colorTitle,
  }) =>
      TextStyle(
        color: color,
        fontSize: Dimens.size12,
        fontFamily: _fontFamilySFProMedium,
      );
}
