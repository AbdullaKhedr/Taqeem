import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_student.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final Stream<QuerySnapshot> _studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const EditStudent(student: {});
              },
            ),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ));
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  data['id'] = document.id;
                  return Card(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.indigo,
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: const Text('Edit'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return EditStudent(student: data);
                                  },
                                ),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return EditStudent(student: data);
                                  },
                                ),
                              );
                            },
                          ),
                          PopupMenuItem(
                            child: const Text('Delete'),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('students')
                                  .doc(data['id'])
                                  .delete();
                            },
                          ),
                        ],
                      ),
                      title: Text(data['name']),
                      subtitle: Text(data['score'].toString()),
                    )
                  ]));
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
