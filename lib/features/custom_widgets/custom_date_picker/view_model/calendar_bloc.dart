import 'package:bloc/bloc.dart';
import 'package:realtime_innovations/utils/extension/date_extension.dart';

import '../../../../utils/logger.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  DateTime? _focusedDay = DateTime.now();

  CalendarBloc() : super(CalendarState(DateTime.now())){

    on<SetSelectedDateEvent>((event, emit) {
      _focusedDay = event.selectedDate;
      emit(CalendarState(_focusedDay));
    });
    on<SetToday>((event, emit) {
      final today = DateTime.now();
      _focusedDay = today;
      emit(CalendarState(today));
    });

    on<SetNextMonday>((event, emit) {
      final nextMonday = DateTime.now().nextMonday;
      _focusedDay = nextMonday;
      emit(CalendarState(nextMonday));
    });

    on<SetNextTuesday>((event, emit) {
      final nextTuesday = DateTime.now().nextTuesday;
      _focusedDay = nextTuesday;
      emit(CalendarState(nextTuesday));
    });

    on<SetAfterAWeek>((event, emit) {
      final afterAWeek = DateTime.now().add(const Duration(days: 7));
      _focusedDay = afterAWeek;
      emit(CalendarState(afterAWeek));
    });

    on<NoDate>((event, emit) {
      _focusedDay = null;
      emit(CalendarState(null));
    });
  }

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {

    if ( event is SetSelectedDateEvent) {
      yield CalendarState(event.selectedDate);
    }
  }
}

