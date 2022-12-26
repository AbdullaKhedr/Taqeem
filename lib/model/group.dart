import 'Student.dart';

class Group {
  final int id;
  final String name;
  final int score;
  final List<Student> students;

  const Group(
    this.id,
    this.name,
    this.score,
    this.students,
  );
}
