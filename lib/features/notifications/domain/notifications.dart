class Notifications {
  final String id;
  final String teacherId;
  final String studentId;
  final String eventId;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  Notifications({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.eventId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id']?.toString() ?? '',
      teacherId: json['teacher_id']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      type: json['type']?.toString() ?? 'attendance',
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacher_id': teacherId,
      'student_id': studentId,
      'event_id': eventId,
      'title': title,
      'body': body,
      'type': type,
      'is_read': isRead,
    };
  }
}