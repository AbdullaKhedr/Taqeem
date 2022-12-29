import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taqeem/model/student.dart';

import 'edit_student.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  var _dropdownValue;

  dropdownCallback(value) {
    setState(() {
      _dropdownValue = value;
    });
  }

  final Stream<QuerySnapshot> _studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _studentsStream,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return const Text('Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text("Loading");
  //       }

  //       return ListView(
  //         children: snapshot.data!.docs
  //             .map((DocumentSnapshot document) {
  //               Map<String, dynamic> data =
  //                   document.data()! as Map<String, dynamic>;
  //               return ListTile(
  //                 title: Text(data['name']),
  //                 subtitle: Text(data['score'].toString()),
  //               );
  //             })
  //             .toList()
  //             .cast(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const EditStudent();
              },
            ),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: _dropdownValue,
              items: const [
                DropdownMenuItem(
                  value: "data",
                  child: Text("data"),
                ),
                DropdownMenuItem(
                  value: "data1",
                  child: Text("data1"),
                ),
                DropdownMenuItem(
                  value: "data11",
                  child: Text("data11"),
                ),
              ],
              onChanged: dropdownCallback,
            ),
          ],
        ),
      ),
    );
  }
}
