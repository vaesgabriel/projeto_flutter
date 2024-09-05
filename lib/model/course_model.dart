class CourseEntity {
  String? id;
  String? name;
  String? description;
  DateTime? startAt; // Mantido como DateTime

  CourseEntity({
    this.id,
    this.name,
    this.description,
    this.startAt,
  });

  static CourseEntity fromJson(Map<String, dynamic> map) {
    return CourseEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      startAt: map['startAt'] != null ? DateTime.parse(map['startAt']) : null,
    );
  }

  static Map<String, dynamic> toJson(CourseEntity courseEntity) {
    return {
      'name': courseEntity.name,
      'description': courseEntity.description,
      'startAt': courseEntity.startAt?.toIso8601String(), // Converte DateTime para String
    };
  }
}
