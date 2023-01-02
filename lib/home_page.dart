import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taqeem/screens/grades_screen.dart';

import 'screens/groups_scrreen/groups_screen.dart';
import 'screens/student_screen/students_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> screenBody = const [
    GroupsScreen(),
    StudentsScreen(),
    GradesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Text(FirebaseAuth.instance.currentUser.toString()),
            ElevatedButton(
              child: const Text("LogOut"),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
      body: screenBody[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            label: "Groups",
            icon: Icon(Icons.group),
          ),
          NavigationDestination(
            label: "Students",
            icon: Icon(Icons.person),
          ),
          NavigationDestination(
            label: "Rubrics",
            icon: Icon(Icons.grading),
          ),
        ],
      ),
    );
  }
}
