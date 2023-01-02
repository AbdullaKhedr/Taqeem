import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.student});

  final Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Text(
            'Name: ${student['name']}',
            style: const TextStyle(
              backgroundColor: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Total Score: ${student['score'].toString()}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
