enum BottomNavBarItemType {
  movieList,
  ticket,
  notifications,
  profile;

  static BottomNavBarItemType toType(int index) =>
      BottomNavBarItemType.values[index];
}
