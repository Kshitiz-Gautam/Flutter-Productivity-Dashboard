import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import '../models/habit_model.dart';
import '../models/note_model.dart';

class StorageService {
  static const String taskKeyName = "tasks_data";
  static const String habitKeyName = "habits_data";
  static const String noteKeyName = "notes_data";
  static const String selectedDateKeyName = "selected_date";

  // -------- TASKS --------
  static Future<void> saveTasks(Map<String, List<Task>> taskMap) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonMap = {};

    taskMap.forEach((key, taskList) {
      jsonMap[key] = taskList.map((task) => task.toMap()).toList();
    });

    prefs.setString(taskKeyName, jsonEncode(jsonMap));
  }

  static Future<Map<String, List<Task>>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(taskKeyName);

    if (data == null) return {};

    final decoded = jsonDecode(data) as Map<String, dynamic>;
    Map<String, List<Task>> result = {};

    decoded.forEach((key, value) {
      final list = value as List<dynamic>;
      result[key] = list.map((e) => Task.fromMap(e as Map<String, dynamic>)).toList();
    });

    return result;
  }

  // -------- HABITS --------
  static Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = habits.map((h) => h.toMap()).toList();
    prefs.setString(habitKeyName, jsonEncode(jsonList));
  }

  static Future<List<Habit>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(habitKeyName);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.map((e) => Habit.fromMap(e)).toList();
  }

  // -------- NOTES --------
  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = notes.map((n) => n.toMap()).toList();
    prefs.setString(noteKeyName, jsonEncode(jsonList));
  }

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(noteKeyName);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.map((e) => Note.fromMap(e)).toList();
  }

  // -------- SELECTED DATE --------
  static Future<void> saveSelectedDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(selectedDateKeyName, date.toIso8601String());
  }

  static Future<DateTime> loadSelectedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(selectedDateKeyName);

    if (data == null) return DateTime.now();

    return DateTime.parse(data);
  }
}
