import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditGroup extends StatefulWidget {
  const EditGroup({super.key});

  @override
  State<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  final groupNameController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: groupNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                var uid = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance.collection("groups").add({
                  'name': groupNameController.text.trim(),
                  'score': 0,
                  'students': [],
                  'admins': [uid]
                });
                Navigator.of(context).pop();
              },
              child: const Text("Create Group"),
            ),
          ],
        ),
      ),
    );
  }
}
