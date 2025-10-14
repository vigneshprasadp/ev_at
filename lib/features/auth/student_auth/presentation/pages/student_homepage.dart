import 'package:attend_event/features/auth/student_auth/domain/entities/student.dart';
import 'package:attend_event/features/auth/student_auth/presentation/cubit/student_auth_cubit.dart';
import 'package:attend_event/features/events/presentation/pages/event_creation_screen.dart';
import 'package:attend_event/features/events/presentation/pages/my_events_screen.dart';
import 'package:attend_event/features/events/presentation/pages/event_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomepage extends StatefulWidget {
  final Student student;
  const StudentHomepage({super.key, required this.student});

  @override
  State<StudentHomepage> createState() => _StudentHomepageState();
}

class _StudentHomepageState extends State<StudentHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.student.name}'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<StudentAuthCubit>().signout();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quick Actions Section
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Create Event Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            CreateEventScreen(studentId: widget.student.id),
                  ),
                );
              },
              icon: Icon(Icons.add_circle_outline),
              label: Text('Create New Event'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 12),

            // My Events Button
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            MyEventsScreen(studentId: widget.student.id),
                  ),
                );
              },
              icon: Icon(Icons.event),
              label: Text('My Events'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 32),

            // Event Categories Section
            Text(
              'Join Events',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Event Categories Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCategoryCard(
                    context,
                    'NCC',
                    Colors.green,
                    Icons.military_tech,
                  ),
                  _buildCategoryCard(context, 'NSS', Colors.blue, Icons.people),
                  _buildCategoryCard(
                    context,
                    'Sports',
                    Colors.orange,
                    Icons.sports_soccer,
                  ),
                  _buildCategoryCard(
                    context,
                    'All Events',
                    Colors.purple,
                    Icons.all_inclusive,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String category,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => EventListScreen(
                    category: category == 'All Events' ? 'all' : category,
                    studentId: widget.student.id,
                    studentName: widget.student.name,
                  ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
