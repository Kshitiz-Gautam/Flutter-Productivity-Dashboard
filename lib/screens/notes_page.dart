import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/note_provider.dart';
import '../providers/search_provider.dart';
import 'add_note_page.dart';
import 'note_details_page.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);
    final searchText = ref.watch(noteSearchProvider);

    final filteredNotes = notes.where((note) {
      return note.title.toLowerCase().contains(searchText.toLowerCase()) ||
          note.content.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Search notes...",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (value) =>
                ref.read(noteSearchProvider.notifier).state = value,
          ),
        ),
        Expanded(
          child: filteredNotes.isEmpty
              ? const Center(child: Text("No notes found."))
              : ListView.builder(
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(
                          note.content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteDetailsPage(note: note),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            final realIndex = notes.indexOf(note);
                            ref
                                .read(noteProvider.notifier)
                                .deleteNote(realIndex);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton.extended(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNotePage()),
            ),
            label: const Text("New Note"),
            icon: const Icon(Icons.edit),
          ),
        )
      ],
    );
  }
}
