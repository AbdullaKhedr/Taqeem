import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taqeem/model/student.dart';

import '../../model/group.dart';

class EditGroup extends StatefulWidget {
  const EditGroup({super.key});

  @override
  State<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  final groupNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var _dropdownValue;

  dropdownCallback(value) {
    setState(() {
      _dropdownValue = value;
    });
  }

  Future createGroup(Group group) async {
    final groupsCollection = FirebaseFirestore.instance.collection("groups");
    groupsCollection.add(group.toMap());
  }

  List<Student> staticData = [
    const Student("name1", 2),
    const Student("name2", 9),
    const Student("name3", 6),
    const Student("name4", 29),
    const Student("name5", 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
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
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ListView.builder(
                itemBuilder: (builder, index) {
                  Student data = staticData[index];
                  return ListTile(
                    title: Text(data.name),
                    leading: CircleAvatar(
                      child: Text('${data.score}'),
                    ),
                  );
                },
                itemCount: staticData.length,
              ),
              ElevatedButton(
                onPressed: () {
                  var uid = FirebaseAuth.instance.currentUser!.uid;
                  final group =
                      Group(groupNameController.text.trim(), 0, [], [uid]);
                  createGroup(group);
                },
                child: const Text("Create Group"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
