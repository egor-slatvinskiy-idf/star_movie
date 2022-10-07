enum BottomNavBarItemType {
  movieList,
  ticket,
  notifications,
  profile,
}

extension BottomNavBarItemTypeExtension on BottomNavBarItemType {
  static const unsupportedType = 'unsupported item type';

  static BottomNavBarItemType toType(int index) {
    try {
      return BottomNavBarItemType.values[index];
    } catch (e) {
      throw Exception(unsupportedType);
    }
  }
}
