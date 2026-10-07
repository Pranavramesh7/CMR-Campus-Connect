import 'package:flutter/material.dart';

import '../models/campus_data.dart';
import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';

/// Opened with a direct MaterialPageRoute. Returns true when the student
/// registers, so the Events screen can show confirmation.
class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});

  final CampusEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: buildCampusAppBar(context, 'Event details'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [event.color, event.color.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.type,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: campusCardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    style: const TextStyle(
                      color: CampusColors.navy,
                      fontSize: 14,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _row(Icons.event_rounded, 'Date', '${event.day} ${event.month} 2026'),
                  _row(Icons.access_time_rounded, 'Time', event.time),
                  _row(Icons.place_rounded, 'Venue', event.venue),
                ],
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: event.registered
                  ? null
                  : () => Navigator.pop(context, true),
              icon: Icon(
                event.registered
                    ? Icons.check_circle_rounded
                    : Icons.how_to_reg_rounded,
              ),
              label: Text(
                event.registered ? 'Already registered' : 'Register for event',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: CampusColors.navy,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(54),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: event.color),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              color: CampusColors.muted,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: CampusColors.navy,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
