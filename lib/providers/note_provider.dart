import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note_model.dart';
import '../services/storage_service.dart';

final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]) {
    load();
  }

  Future<void> load() async {
    state = await StorageService.loadNotes();
  }

  void addNote(String title, String content) {
    state = [
      ...state,
      Note(
        title: title,
        content: content,
        createdAt: DateTime.now(),
      ),
    ];

    StorageService.saveNotes(state);
  }

  void deleteNote(int index) {
    state = [...state]..removeAt(index);
    StorageService.saveNotes(state);
  }
}
