import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>((ref) {
  return SelectedDateNotifier();
});

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier() : super(DateTime.now()) {
    load();
  }

  Future<void> load() async {
    state = await StorageService.loadSelectedDate();
  }

  void setDate(DateTime date) {
    state = date;
    StorageService.saveSelectedDate(date);
  }
}
