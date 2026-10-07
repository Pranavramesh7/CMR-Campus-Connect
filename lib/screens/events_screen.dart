import 'package:flutter/material.dart';

import '../models/campus_data.dart';
import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';
import 'event_detail_screen.dart';

/// Named route: AppRoutes.events
/// Opens EventDetailScreen with a direct Navigator.push + MaterialPageRoute.
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<CampusEvent> _events = buildSampleEvents();
  bool _opening = false; // blocks duplicate pushes from rapid taps

  Future<void> _openEvent(CampusEvent event) async {
    if (_opening) return;
    _opening = true;

    // Direct route (no route name) with the Event passed to the constructor.
    final registered = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => EventDetailScreen(event: event)),
    );

    _opening = false;
    if (!context.mounted) return;

    if (registered == true) {
      setState(() => event.registered = true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: CampusColors.navy,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Text(
              "You're registered for ${event.title}.",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: buildCampusAppBar(context, 'Campus Events'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            for (final event in _events)
              _EventCard(event: event, onTap: () => _openEvent(event)),
          ],
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.onTap});

  final CampusEvent event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: campusCardDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 62,
                  width: 56,
                  decoration: BoxDecoration(
                    color: event.color.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        event.day,
                        style: TextStyle(
                          color: event.color,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        event.month,
                        style: TextStyle(
                          color: event.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          color: CampusColors.navy,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${event.time}  •  ${event.venue}',
                        style: const TextStyle(
                          color: CampusColors.muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.registered ? 'REGISTERED' : 'NOT REGISTERED',
                        style: TextStyle(
                          color: event.registered
                              ? const Color(0xFF18A184)
                              : CampusColors.muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: CampusColors.muted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
