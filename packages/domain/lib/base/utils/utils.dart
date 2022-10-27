class Utils {
  const Utils._();

  static const idName = 'trakt';
  static const trendingType = 1;
  static const comingType = 2;


  static bool isTodayDate(DateTime? dateLoad) {
    if (dateLoad != null) {
      final currentDate = DateTime.now();
      return currentDate.year == dateLoad.year &&
          currentDate.month == dateLoad.month &&
          currentDate.day == dateLoad.day;
    } else {
      return false;
    }
  }
}