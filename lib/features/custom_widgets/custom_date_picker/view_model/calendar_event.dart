
abstract class CalendarEvent {}

class SetSelectedDateEvent extends CalendarEvent {
  final DateTime selectedDate;
  SetSelectedDateEvent(this.selectedDate);
}

class SetToday extends CalendarEvent{

}

class SetNextMonday extends CalendarEvent{
  final DateTime selectedDate;
  SetNextMonday(this.selectedDate);
}

class SetNextTuesday extends CalendarEvent{
}

class SetAfterAWeek extends CalendarEvent{
}

class NoDate extends CalendarEvent{
}