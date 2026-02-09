import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/habit_provider.dart';

class HabitPage extends ConsumerWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Column(
      children: [
        Expanded(
          child: habits.isEmpty
              ? const Center(child: Text("Start a new habit!"))
              : ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habit = habits[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(habit.name),
                        subtitle: Text("Streak: ${habit.streak} days"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                habit.doneToday
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color:
                                    habit.doneToday ? Colors.green : Colors.grey,
                              ),
                              onPressed: () => ref
                                  .read(habitProvider.notifier)
                                  .markDone(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => ref
                                  .read(habitProvider.notifier)
                                  .resetToday(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => ref
                                  .read(habitProvider.notifier)
                                  .deleteHabit(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton.extended(
            onPressed: () => _showAddHabitDialog(context, ref),
            label: const Text("Add Habit"),
            icon: const Icon(Icons.add),
          ),
        )
      ],
    );
  }

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Habit"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Drink water, Meditate..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref
                    .read(habitProvider.notifier)
                    .addHabit(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}
