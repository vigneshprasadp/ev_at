class Teacher {
  final String id;
  final String teacherId;
  final String name;
  final String? email;
  final String? department;
  final String? password;

  Teacher({
    required this.id,
    required this.teacherId,
    required this.name,
    this.email,
    this.department,
    this.password,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id']?.toString() ?? '', // Handle null
      teacherId: json['teacher_id']?.toString() ?? '', // Handle null
      name: json['name']?.toString() ?? 'Unknown Teacher', // Handle null
      email: json['email']?.toString(), // Can be null
      department: json['department']?.toString(), // Can be null
      password: json['password']?.toString(), // Can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'name': name,
      'email': email,
      'department': department,
      'password': password,
    };
  }
}
