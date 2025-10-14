import 'package:attend_event/features/auth/teacher_auth/domain/entities/teacher.dart';
import 'package:attend_event/features/events/presentation/pages/teacher_notifiactions.dart';
import 'package:attend_event/features/events/presentation/pages/tecaher_request_creation.dart';
import 'package:attend_event/features/notifications/domain/notifications.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeacherHomePage extends StatelessWidget {
  final Teacher teacher;
  const TeacherHomePage({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${teacher.name}"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Real-time Notification Badge
          StreamBuilder<List<Notifications>>(
            stream: _getUnreadNotificationsStream(),
            builder: (context, snapshot) {
              final unreadCount = snapshot.data?.length ?? 0;
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherNotificationsScreen(teacherId: teacher.id),
                        ),
                      );
                    },
                    icon: Icon(Icons.notifications),
                    tooltip: 'Notifications',
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          unreadCount > 9 ? '9+' : unreadCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teacher Info Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "👨‍🏫 Teacher Profile",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow('🏫 Department', teacher.department!),
                    _buildInfoRow('📧 Email', teacher.email ?? 'Not provided'),
                    _buildInfoRow('🆔 Teacher ID', teacher.teacherId),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // Quick Actions
            Text(
              '🚀 Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            
            // Action Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildActionCard(
                    context,
                    '📋 Event Requests',
                    Icons.pending_actions,
                    Colors.orange,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherRequestsScreen(teacherId: teacher.id),
                        ),
                      );
                    },
                  ),
                  _buildActionCard(
                    context,
                    '🔔 Notifications',
                    Icons.notifications,
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherNotificationsScreen(teacherId: teacher.id),
                        ),
                      );
                    },
                  ),
                  _buildActionCard(
                    context,
                    '📊 Attendance Reports',
                    Icons.assignment,
                    Colors.green,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('📊 Attendance Reports - Coming Soon!')),
                      );
                    },
                  ),
                  _buildActionCard(
                    context,
                    '👤 My Profile',
                    Icons.person,
                    Colors.purple,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('👤 Profile Management - Coming Soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.1),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Real-time unread notifications stream
  Stream<List<Notifications>> _getUnreadNotificationsStream() {
    return Supabase.instance.client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .map((maps) => maps
            .where((map) => map['teacher_id'] == teacher.id && map['is_read'] == false)
            .map((map) => Notifications.fromJson(map))
            .toList()
        );
  }
}