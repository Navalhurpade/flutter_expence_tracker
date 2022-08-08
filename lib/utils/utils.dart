bool compaireDate(DateTime date1, DateTime date2) {
  return (date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day);
}

double addWeekDay(int d) {
  if (d >= 7) {
    return 1;
  }
  return (d + 1).toDouble();
}
