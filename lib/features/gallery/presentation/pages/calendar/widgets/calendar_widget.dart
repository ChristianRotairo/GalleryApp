import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gal_app/features/utilities/colors.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(CalendarFormat) onFormatChanged;
  final void Function(DateTime) onPageChanged;

  const CalendarWidget({
    required this.calendarFormat,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          
          shadowColor: const Color.fromARGB(255, 157, 157, 157),
          color: backgroundColor,
          child: TableCalendar(
            firstDay: DateTime(1900),
            lastDay: DateTime(2100),
            focusedDay: focusedDay,
            calendarFormat: calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            onDaySelected: onDaySelected,
            onFormatChanged: onFormatChanged,
            onPageChanged: onPageChanged,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 83, 83, 83),
                shape: BoxShape.circle,
              ),
              // Days cell styles
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.white),
              outsideTextStyle: TextStyle(color: Colors.grey),
              todayTextStyle: TextStyle(color: Colors.white),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            // Weeks style
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.white),
              weekdayStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              // Month and year header styles
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              // Weeks button next to icon chevron right
              formatButtonTextStyle: const TextStyle(color: Colors.white),
              formatButtonDecoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              headerMargin: const EdgeInsets.only(bottom: 8.0),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: [
              const Text(
                'No event for today',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Image.asset('assets/image/calendar.png'),
            ],
          ),
        ),
      ],
    );
  }
}
