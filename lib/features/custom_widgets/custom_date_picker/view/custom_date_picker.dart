import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations/utils/extension/date_extension.dart';
import '../../../../config/resources/AppContextExtension.dart';
import '../../../../generated/assets.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../custom_button.dart';
import '../view_model/calendar_bloc.dart';
import '../view_model/calendar_event.dart';
import '../view_model/calendar_state.dart';

Future<DateTime?> customDatePicker(
    {required BuildContext context, bool isJoiningDate = true}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            content: StatefulBuilder(builder: (context, setState) {
              return  CustomCalender(
                isJoiningDate: isJoiningDate,
              );
            }));
      }).then((value) {
    if (value != null) {
      return value as DateTime;
    }
  });
}

class CustomCalender extends StatelessWidget {
  const CustomCalender({required this.isJoiningDate, super.key});

  final bool isJoiningDate;

  @override
  Widget build(BuildContext context) {
    // final CalendarBloc calendarBloc = BlocProvider.of<CalendarBloc>(context);

    return BlocProvider(
        create: (context) => CalendarBloc(),
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            DateTime? selectedDate = state.selectedDate;
            DateTime today = DateTime.now();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                isJoiningDate
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              customButton(
                                  height: 35,
                                  width: context.width * 0.4,
                                  fontWeight: FontWeight.w400,
                                  text: 'Today',
                                  onTap: () {
                                    context.read<CalendarBloc>().add(SetToday());
                                  }),
                              customButton(
                                  height: 35,
                                  highlightButton: true,
                                  width: context.width * 0.4,
                                  fontWeight: FontWeight.w400,
                                  text: 'Next Monday',
                                  onTap: () {
                                    context.read<CalendarBloc>().add(SetNextMonday(today));
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              customButton(
                                  height: 35,
                                  width: context.width * 0.4,
                                  fontWeight: FontWeight.w400,
                                  text: 'Next Tuesday',
                                  onTap: () {
                                    context.read<CalendarBloc>().add(SetNextTuesday());
                                  }),
                              customButton(
                                  height: 35,
                                  width: context.width * 0.4,
                                  fontWeight: FontWeight.w400,
                                  text: 'After 1 Week',
                                  onTap: () {
                                    context.read<CalendarBloc>().add(SetAfterAWeek());
                                  }),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customButton(
                              height: 35,
                              highlightButton: true,
                              width: context.width * 0.4,
                              fontWeight: FontWeight.w400,
                              text: 'No Date',
                              onTap: () {
                                context.read<CalendarBloc>().add(NoDate());
                              }),
                          customButton(
                              height: 35,
                              width: context.width * 0.4,
                              fontWeight: FontWeight.w400,
                              text: 'Today',
                              onTap: () {
                                context.read<CalendarBloc>().add(SetToday());
                              }),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {

                          if(!(!isJoiningDate &&selectedDate!=null&&selectedDate.year==today.year&&selectedDate.month==today.month)){
                            if (selectedDate == null) {
                              context.read<CalendarBloc>().add(SetSelectedDateEvent(
                                  DateTime(today.year, today.month, 0)));
                            } else {
                              context.read<CalendarBloc>().add(SetSelectedDateEvent(DateTime(
                                  selectedDate.year, selectedDate.month,0)));
                            }
                          }
                        },
                        color: (!isJoiningDate &&selectedDate!=null&&selectedDate.year==today.year&&selectedDate.month==today.month)? const Color(0xffE5E5E5):const Color(0xff949C9E),
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        iconSize: 50,
                        icon: const Icon(
                          Icons.arrow_left_rounded,
                        )),
                    Text(
                      selectedDate == null
                          ? today.formatDate(withoutDay: true)
                          : selectedDate.formatDate(withoutDay: true),
                      style: context.resources.textStyle.heading1
                          .copyWith(color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          if (selectedDate == null) {
                            context.read<CalendarBloc>().add(SetSelectedDateEvent(
                                DateTime(today.year, today.month + 1)));
                          } else {
                            context.read<CalendarBloc>().add(SetSelectedDateEvent(DateTime(
                                selectedDate.year, selectedDate.month + 1)));
                          }
                        },
                        padding: EdgeInsets.zero,
                        iconSize: 50,
                        color: const Color(0xff949C9E),
                        splashRadius: 20,
                        icon: const Icon(
                          Icons.arrow_right_rounded,
                        )),
                  ],
                ),
                SizedBox(
                  width: context.width * 0.93,
                  height: 348,
                  child: TableCalendar(
                    firstDay: isJoiningDate?DateTime.utc(2010, 1, 1):today,
                    lastDay: DateTime(today.year+10),
                    pageJumpingEnabled: false,
                    currentDay: DateTime.now(),
                    focusedDay: selectedDate??today,
                    headerVisible: false,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: context.resources.textStyle.bodyText2,
                      weekendStyle: context.resources.textStyle.bodyText2,
                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      tablePadding: const EdgeInsets.all(10),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xff1DA1F2),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xff1DA1F2),
                          width: 2.0,
                        ),
                      ),
                      todayTextStyle: const TextStyle(
                        color: Color(0xff1DA1F2),
                        fontWeight: FontWeight.bold,
                      ),
                      defaultTextStyle: context.resources.textStyle.bodyText2,
                      weekendTextStyle: context.resources.textStyle.bodyText2,
                      holidayTextStyle: context.resources.textStyle.bodyText2,
                      weekNumberTextStyle:
                          context.resources.textStyle.bodyText2,
                    ),
                    onPageChanged: (date) {
                      BlocProvider.of<CalendarBloc>(context)
                          .add(SetSelectedDateEvent(date));

                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      BlocProvider.of<CalendarBloc>(context)
                          .add(SetSelectedDateEvent(selectedDay));

                    },
                  ),
                ),
                const Divider(thickness: 2,color: Color(0xffF2F2F2),),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Assets.iconsCalenderIcon,
                              cacheHeight: 23),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            selectedDate==null?'No Date':
                            selectedDate.formatDate(shortName: true),
                            style: context.resources.textStyle.bodyText2,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customButton(
                              text: 'Cancel',
                              onTap: () {
                                Navigator.pop(context);
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          customButton(
                              text: 'Save',
                              highlightButton: true,
                              onTap: () {
                                Navigator.pop(context, selectedDate);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
