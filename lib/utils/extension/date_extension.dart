extension DateTimeExpension on DateTime{



  String formatDate({ bool shortName=false, bool withoutDay=false,bool withComma=false}) {
    String day = this.day.toString();
    String month = _getMonthName(this.month);
    String year = this.year.toString();
    if(withComma){
      return "${withoutDay?'':'$day '}${month.substring(0,3)}, $year";
    }
    if(shortName){
      return "${withoutDay?'':'$day '}${month.substring(0,3)} $year";
    }
    return "${withoutDay?'':'$day '}$month $year";
  }

  DateTime get nextMonday {
    final daysUntilNextMonday = 8 - weekday;
    return add(Duration(days: daysUntilNextMonday));
  }

  DateTime get nextTuesday {
    final daysUntilNextTuesday = 9 - weekday;
    return add(Duration(days: daysUntilNextTuesday));
  }

}

String _getMonthName(int month) {
  List<String> months = [
    "", // Index 0 is not used
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month];
}