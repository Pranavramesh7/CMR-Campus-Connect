import 'package:flutter/material.dart';

import '../models/campus_data.dart';
import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';

/// Named route: AppRoutes.timetable
class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: buildCampusAppBar(context, 'Timetable'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            const Text(
              'THIS WEEK',
              style: TextStyle(
                color: CampusColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
              ),
            ),
            const SizedBox(height: 11),
            for (final entry in timetableEntries) _ClassCard(entry: entry),
          ],
        ),
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  const _ClassCard({required this.entry});

  final ClassEntry entry;

  @override
  Widget build(BuildContext context) {
    final highlighted = entry.isNext; // the single "next class" highlight
    final textColor = highlighted ? Colors.white : CampusColors.navy;
    final subColor = highlighted ? Colors.white70 : CampusColors.muted;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: highlighted
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [CampusColors.blue, CampusColors.purple],
              )
            : null,
        color: highlighted ? null : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: (highlighted ? CampusColors.blue : Colors.black)
                .withOpacity(highlighted ? 0.25 : 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: highlighted
                  ? Colors.white.withOpacity(0.2)
                  : CampusColors.blue.withOpacity(0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              entry.day,
              style: TextStyle(
                color: highlighted ? Colors.white : CampusColors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (highlighted)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'NEXT CLASS',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                Text(
                  entry.module,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${entry.time}  •  ${entry.room}',
                  style: TextStyle(
                    color: subColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
