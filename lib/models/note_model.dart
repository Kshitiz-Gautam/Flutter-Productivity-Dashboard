class Note {
  final String title;
  final String content;
  final DateTime createdAt;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map["title"] ?? "",
      content: map["content"] ?? "",
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}
