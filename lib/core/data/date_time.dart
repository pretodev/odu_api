extension DateTimeExtensions on DateTime {
  DateTime get onlyDate => DateTime(year, month, day);

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return onlyDate.compareTo(today) == 0;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return onlyDate.compareTo(tomorrow) == 0;
  }

  DateTime get firstTimeOfMonth {
    return copyWith(
      day: 1,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );
  }

  DateTime get lastTimeOfMonth {
    final nextMonth = month == 12
        ? DateTime(year + 1, 1)
        : DateTime(year, month + 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1));
    return copyWith(
      day: lastDay.day,
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );
  }
}
