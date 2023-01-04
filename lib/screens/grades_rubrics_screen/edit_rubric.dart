import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditRubric extends StatefulWidget {
  const EditRubric({super.key, required this.reubric});
  final Map<String, dynamic> reubric;
  @override
  State<EditRubric> createState() => _EditRubricState();
}

enum RubricsTypes {
  individual('individual'),
  group('group');

  final String name;
  const RubricsTypes(this.name);
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

  final dropDownOptions = [RubricsTypes.individual, RubricsTypes.group];
  String _dropdownValue = RubricsTypes.individual.name;

  Future updateRubric(Map<String, dynamic> reubric) async {
    print(reubric);
    if (reubric['type'] == RubricsTypes.individual.name) {
      FirebaseFirestore.instance
          .collection("individual-grading-rubrics")
          .doc(reubric['name'])
          .set(reubric);
    } else if (reubric['type'] == RubricsTypes.group.name) {
      FirebaseFirestore.instance
          .collection("group-grading-rubrics")
          .doc(reubric['name'])
          .set(reubric);
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
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: rubricWeightController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Rubric Weight (out of 100)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              isExpanded: true,
              hint: const Text("Rubric Type"),
              decoration: InputDecoration(
                  label: const Text("Type"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              value: _dropdownValue,
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value!;
                });
              },
              items: dropDownOptions.map(
                (RubricsTypes value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(value.name),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                updateRubric({
                  'name': rubricNameController.text.trim(),
                  'weight': rubricWeightController.text.trim(),
                  'type': _dropdownValue
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
