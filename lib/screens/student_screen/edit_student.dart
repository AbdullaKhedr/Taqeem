import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taqeem/model/student.dart';

class EditStudent extends StatefulWidget {
  const EditStudent({super.key});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final groupNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future updateStudent(Student student) async {
    final groupsCollection = FirebaseFirestore.instance.collection("students");
    groupsCollection.add(student.toMap());
  }

  @override
  Widget build(BuildContext context) {
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
                controller: groupNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final student = Student(groupNameController.text.trim(), 0);
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
