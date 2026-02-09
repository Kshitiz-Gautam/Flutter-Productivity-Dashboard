class Habit {
  final String name;
  int streak;
  bool doneToday;

  Habit({
    required this.name,
    this.streak = 0,
    this.doneToday = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "streak": streak,
      "doneToday": doneToday,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      name: map["name"] ?? "",
      streak: map["streak"] ?? 0,
      doneToday: map["doneToday"] ?? false,
    );
  }
}
