import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NoteDetailsPage extends StatelessWidget {
  final Note note;
  const NoteDetailsPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Note Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
              "${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}",
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 30),
            Text(note.content, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
