import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditRubric extends StatefulWidget {
  const EditRubric({super.key, required this.reubric});
  final Map<String, dynamic> reubric;
  @override
  State<EditRubric> createState() => _EditRubricState();
}

class _EditRubricState extends State<EditRubric> {
  final rubricNameController = TextEditingController();
  final rubricWeightController = TextEditingController();

  @override
  void dispose() {
    rubricNameController.dispose();
    rubricWeightController.dispose();
    super.dispose();
  }

  final dropDownOptions = ["Individual", "Group"];
  String _dropdownValue = "Individual";

  Future updateRubric(Map<String, dynamic> reubric) async {
    final ruprecsCollection = FirebaseFirestore.instance.collection("rubrics");
    if (widget.reubric['id'] != null) {
      ruprecsCollection.doc(reubric['id']).update(reubric);
    } else {
      ruprecsCollection.add(reubric);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Grading Rubrics"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: rubricNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Rubric Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: rubricWeightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Rubric Weight',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Rubric Type"),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _dropdownValue,
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value!;
                });
              },
              items: dropDownOptions.map(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              isExpanded: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateRubric({
                  'name': rubricNameController.text.trim(),
                  'weight': rubricWeightController.text.trim(),
                  'type': _dropdownValue.toString()
                });
                Navigator.of(context).pop();
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
