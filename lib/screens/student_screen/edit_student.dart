import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditStudent extends StatefulWidget {
  const EditStudent({super.key, required this.student});
  final Map<String, dynamic> student;

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final studentNameController = TextEditingController();

  @override
  void dispose() {
    studentNameController.dispose();
    super.dispose();
  }

  Future updateStudent(Map<String, dynamic> student) async {
    final groupsCollection = FirebaseFirestore.instance.collection("students");
    if (widget.student['id'] != null) {
      groupsCollection.doc(student['id']).update(student);
    } else {
      groupsCollection.add(student);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> student = widget.student;
    studentNameController.text = student['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: studentNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  student['name'] = studentNameController.text.trim();
                  student['score'] = widget.student['score'];
                  updateStudent(student);
                  Navigator.of(context).pop();
                },
                child: const Text("Done"),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Import from excel file"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
