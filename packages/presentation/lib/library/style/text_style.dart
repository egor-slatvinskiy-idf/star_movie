import 'package:flutter/material.dart';
import 'package:presentation/library/dimens/dimens.dart';

const _fontFamilySFProSemiBold = 'SF Pro Text Semibold';
const _fontFamilySFProMedium = 'SF Pro Text Medium';


TextStyle sfProSemi24({
  required Color color,
}) {
  return TextStyle(
    color: color,
    fontSize: Dimens.size24,
    fontFamily: _fontFamilySFProSemiBold,
  );
}

TextStyle sfProSemi16({
  required Color color,
}) {
  return TextStyle(
    color: color,
    fontSize: Dimens.size16,
    fontFamily: _fontFamilySFProSemiBold,
  );
}

TextStyle sfProSemi30({
  required Color color,
}) {
  return TextStyle(
    color: color,
    fontSize: Dimens.size30,
    fontFamily: _fontFamilySFProSemiBold,
  );
}

TextStyle sfProMed14({
  required Color color,
}) {
  return TextStyle(
    color: color,
    fontSize: Dimens.size14,
    fontFamily: _fontFamilySFProMedium,
  );
}

TextStyle sfProMed18({
  required Color color,
}) {
  return TextStyle(
    color: color,
    fontSize: Dimens.size18,
    fontFamily: _fontFamilySFProMedium,
  );
}

TextStyle sfProMed12({
  required Color color,
}) {
  return TextStyle(
    color: color,
    fontSize: Dimens.size12,
    fontFamily: _fontFamilySFProMedium,
  );
}
