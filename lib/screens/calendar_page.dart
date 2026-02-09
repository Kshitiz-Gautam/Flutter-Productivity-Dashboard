import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/selected_date_provider.dart';
import '../widgets/calendar_grid.dart';

String monthName(int month) {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  return months[month - 1];
}

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(selectedDateProvider.notifier).setDate(
                        DateTime(selectedDate.year, selectedDate.month - 1, 1),
                      );
                },
              ),
              Text(
                "${monthName(selectedDate.month)} ${selectedDate.year}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  ref.read(selectedDateProvider.notifier).setDate(
                        DateTime(selectedDate.year, selectedDate.month + 1, 1),
                      );
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("M"),
              Text("T"),
              Text("W"),
              Text("T"),
              Text("F"),
              Text("S"),
              Text("S")
            ],
          ),
        ),
        Expanded(
          child: CalendarGrid(
            selectedDate: selectedDate,
            onDateSelected: (date) =>
                ref.read(selectedDateProvider.notifier).setDate(date),
          ),
        ),
      ],
    );
  }
}
