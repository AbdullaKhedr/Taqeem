class Student {
  final String name;
  final int score;

  const Student(
    this.name,
    this.score,
  );
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
    };
  }
}
