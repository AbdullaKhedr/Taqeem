import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.student});
  final Map<String, dynamic> student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final rubrics = [];

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("rubrics")
        .where("type", isEqualTo: "Individual")
        .get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    rubrics.addAll(allData);
  }

  @override
  Widget build(BuildContext context) {
    var student = widget.student;
    getData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name: ${student['name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Total Score: ${student['score'].toString()}',
                        style: const TextStyle(
                          backgroundColor: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: ListView(
                //     children: rubrics
                //         .map((document) {
                //           Map<String, dynamic> data =
                //               document.data()! as Map<String, dynamic>;
                //           data['id'] = document.id;
                //           return Card(
                //               child: ListTile(
                //             leading: const Icon(
                //               Icons.credit_score,
                //               size: 40.0,
                //               color: Colors.indigo,
                //             ),
                //             trailing: IconButton(
                //                 onPressed: () {
                //                   FirebaseFirestore.instance
                //                       .collection('rubrics')
                //                       .doc(data['id'])
                //                       .delete();
                //                 },
                //                 icon: const Icon(Icons.delete)),
                //             title: Text(data['name']),
                //             subtitle:
                //                 Text('Weight: ${data['weight'].toString()}'),
                //           ));
                //         })
                //         .toList()
                //         .cast(),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
