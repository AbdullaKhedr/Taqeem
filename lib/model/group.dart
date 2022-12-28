import 'Student.dart';

class Group {
  final String? name;
  final int? score;
  final List<Student>? students;
  final List<String>? adminsIds;

  const Group(
    this.name,
    this.score,
    this.students,
    this.adminsIds,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'students': students,
      'adminsIds': adminsIds,
    };
  }
}
