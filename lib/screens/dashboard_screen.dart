import 'package:flutter/material.dart';

import '../widgets/dashboard_stats.dart';
import 'task_page.dart';
import 'habit_page.dart';
import 'notes_page.dart';
import 'calendar_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const TaskPage(),
    const HabitPage(),
    const NotesPage(),
    const CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Productivity Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const DashboardStats(),
            const Divider(),
            SizedBox(
              height: 600,
              child: pages[selectedIndex],
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (value) => setState(() => selectedIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Habits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: "Notes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
        ],
      ),
    );
  }
}
