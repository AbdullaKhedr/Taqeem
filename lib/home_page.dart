import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:taqeem/model/group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> screenBody = const [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Text(FirebaseAuth.instance.currentUser.toString()),
            ElevatedButton(
              child: const Text("LogOut"),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
      body: screenBody[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Groups",
              icon: Icon(Icons.group),
            ),
            BottomNavigationBarItem(
              label: "Students",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "Rubrics",
              icon: Icon(Icons.grading),
            ),
          ]),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final groupNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    groupNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future createGroup(Group group) async {
    final groupsCollection = FirebaseFirestore.instance.collection("groups");
    groupsCollection.add(group.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: formKey,
                child: Column(
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
                        final group = Group(
                            groupNameController.text.trim(), 0, [], [uid]);
                        createGroup(group);
                      },
                      child: const Text("Create Group"),
                    ),
                  ],
                )),
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
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  var _dropdownValue;

  dropdownCallback(value) {
    setState(() {
      _dropdownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
          ElevatedButton(
            onPressed: () {},
            child: const Text("Import from excel file"),
          )
        ],
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
