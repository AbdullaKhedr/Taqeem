import 'package:flutter/material.dart';
import 'package:taqeem/screens/groups_scrreen/edit_group.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: const [
                      Text("First Team"),
                      Text("Members Count"),
                      Text("Score"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
