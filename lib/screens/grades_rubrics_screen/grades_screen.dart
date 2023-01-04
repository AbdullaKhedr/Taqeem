import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'edit_rubric.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final Stream<QuerySnapshot> _individualRubricsStream = FirebaseFirestore
      .instance
      .collection('individual-grading-rubrics')
      .snapshots();

  final Stream<QuerySnapshot> _groupRubricsStream = FirebaseFirestore.instance
      .collection('group-grading-rubrics')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grading Rubrics"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const EditRubric(
                  reubric: {},
                );
              },
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Individually",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _individualRubricsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              child: ListTile(
                            leading: const Icon(
                              Icons.credit_score,
                              size: 40.0,
                              color: Colors.indigo,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('individual-grading-rubrics')
                                      .doc(data['name'])
                                      .delete();
                                },
                                icon: const Icon(Icons.delete)),
                            title: Text(data['name']),
                            subtitle:
                                Text('Weight: ${data['weight'].toString()}'),
                          ));
                        })
                        .toList()
                        .cast(),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Groups",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _groupRubricsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              child: ListTile(
                            leading: const Icon(
                              Icons.credit_score,
                              size: 40.0,
                              color: Colors.indigo,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('group-grading-rubrics')
                                      .doc(data['name'])
                                      .delete();
                                },
                                icon: const Icon(Icons.delete)),
                            title: Text(data['name']),
                            subtitle:
                                Text('Weight: ${data['weight'].toString()}'),
                          ));
                        })
                        .toList()
                        .cast(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
