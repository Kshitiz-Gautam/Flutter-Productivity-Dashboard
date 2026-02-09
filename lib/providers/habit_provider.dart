import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit_model.dart';
import '../services/storage_service.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]) {
    load();
  }

  Future<void> load() async {
    state = await StorageService.loadHabits();
  }

  void addHabit(String name) {
    state = [...state, Habit(name: name)];
    StorageService.saveHabits(state);
  }

  void markDone(int index) {
    final habits = [...state];

    if (!habits[index].doneToday) {
      habits[index].doneToday = true;
      habits[index].streak++;
    }

    state = habits;
    StorageService.saveHabits(state);
  }

  void resetToday(int index) {
    final habits = [...state];
    habits[index].doneToday = false;

    state = habits;
    StorageService.saveHabits(state);
  }

  void deleteHabit(int index) {
    state = [...state]..removeAt(index);
    StorageService.saveHabits(state);
  }
}
