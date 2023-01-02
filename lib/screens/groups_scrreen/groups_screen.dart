import 'package:flutter/material.dart';
import 'package:taqeem/screens/groups_scrreen/edit_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

enum GroupOptionsMenu { itemOne, itemTwo, itemThree }

class _GroupsScreenState extends State<GroupsScreen> {
  final Stream<QuerySnapshot> _studentsStream =
      FirebaseFirestore.instance.collection('groups').snapshots();

  GroupOptionsMenu? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const EditGroup();
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
                .map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    data['id'] = document.id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Text(data['name']),
                              Text('Score:${data['score'].toString()}'),
                              Text(
                                  'Students count: ${data['students'].length.toString()}')
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
