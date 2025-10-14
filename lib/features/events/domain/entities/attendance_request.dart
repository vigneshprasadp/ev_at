class AttendanceRequest {
  final String eventId;
  final String studentId;
  final String studentClass;
  final String targetTeacherId; // Note: We'll handle the typo in repository
  final String status;
  final DateTime createdAt;

  AttendanceRequest({
    required this.eventId,
    required this.studentId,
    required this.studentClass,
    required this.targetTeacherId,
    required this.status,
    required this.createdAt,
  });

  factory AttendanceRequest.fromJson(Map<String, dynamic> json) {
    return AttendanceRequest(
      eventId: json['event_id']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      studentClass: json['student_class']?.toString() ?? '',
      targetTeacherId: json['target_tsscher_id']?.toString() ?? '', // Handle the typo
      status: json['status']?.toString() ?? 'requested',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'student_id': studentId,
      'student_class': studentClass,
      'target_tsscher_id': targetTeacherId, // Use the actual column name with typo
      'status': status,
    };
  }
}