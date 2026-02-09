import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_provider.dart';
import '../providers/habit_provider.dart';
import '../providers/note_provider.dart';
import '../providers/selected_date_provider.dart';
import 'stats_card.dart';

String dateKey(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}

class DashboardStats extends ConsumerWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final taskMap = ref.watch(taskProvider);
    final habits = ref.watch(habitProvider);
    final notes = ref.watch(noteProvider);

    final key = dateKey(selectedDate);
    final todayTasks = taskMap[key] ?? [];

    final completedTasks = todayTasks.where((t) => t.isDone).length;
    final pendingTasks = todayTasks.where((t) => !t.isDone).length;

    final habitsDone = habits.where((h) => h.doneToday).length;

    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          "Dashboard Stats",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            StatsCard(
              title: "Tasks Today",
              value: "${todayTasks.length}",
              icon: Icons.task_alt,
            ),
            StatsCard(
              title: "Completed",
              value: "$completedTasks",
              icon: Icons.check_circle,
            ),
            StatsCard(
              title: "Pending",
              value: "$pendingTasks",
              icon: Icons.pending_actions,
            ),
            StatsCard(
              title: "Habits",
              value: "${habits.length}",
              icon: Icons.fitness_center,
            ),
            StatsCard(
              title: "Habits Done",
              value: "$habitsDone",
              icon: Icons.done_all,
            ),
            StatsCard(
              title: "Notes",
              value: "${notes.length}",
              icon: Icons.note,
            ),
          ],
        ),
      ],
    );
  }
}
