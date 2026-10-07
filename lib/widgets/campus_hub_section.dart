import 'package:flutter/material.dart';

import '../models/campus_data.dart';
import '../routes/app_routes.dart';
import 'campus_app_bar.dart';
import 'campus_form_fields.dart';

// ============================================================
// CAMPUS PHOTO BANNER (uses assets/campus_life.jpg)
// ============================================================

class CampusPhotoBanner extends StatelessWidget {
  const CampusPhotoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.height = 150,
  });

  final String title;
  final String subtitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/campus_life.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: CampusColors.blue);
              },
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xCC17182B)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CAMPUS HUB: Dashboard section with the named-route links
// ============================================================

class CampusHubSection extends StatelessWidget {
  const CampusHubSection({super.key});

  @override
  Widget build(BuildContext context) {
    final next = timetableEntries.firstWhere(
      (e) => e.isNext,
      orElse: () => timetableEntries.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CAMPUS HUB',
          style: TextStyle(
            color: CampusColors.muted,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 11),
        const CampusPhotoBanner(
          title: 'Explore CMR campus',
          subtitle: 'Classes, services and events in one place',
        ),
        const SizedBox(height: 11),
        _NextClassCard(entry: next),
        const SizedBox(height: 11),
        const Row(
          children: [
            Expanded(
              child: _HubCard(
                title: 'Timetable',
                subtitle: 'Your classes',
                icon: Icons.schedule_rounded,
                color: CampusColors.blue,
                route: AppRoutes.timetable,
              ),
            ),
            SizedBox(width: 11),
            Expanded(
              child: _HubCard(
                title: 'Services',
                subtitle: 'Help & offices',
                icon: Icons.apartment_rounded,
                color: CampusColors.purple,
                route: AppRoutes.services,
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        const Row(
          children: [
            Expanded(
              child: _HubCard(
                title: 'Events',
                subtitle: "What's on",
                icon: Icons.celebration_rounded,
                color: CampusColors.pink,
                route: AppRoutes.events,
              ),
            ),
            SizedBox(width: 11),
            Expanded(
              child: _HubCard(
                title: 'Profile',
                subtitle: 'Your details',
                icon: Icons.badge_rounded,
                color: Color(0xFF18A184),
                route: AppRoutes.profile,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NextClassCard extends StatelessWidget {
  const _NextClassCard({required this.entry});

  final ClassEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: campusCardDecoration(radius: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.pushNamed(context, AppRoutes.timetable),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: CampusColors.mint.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.alarm_rounded,
                    color: Color(0xFF18A184),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NEXT CLASS',
                        style: TextStyle(
                          color: CampusColors.muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        entry.module,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CampusColors.navy,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '${entry.day}, ${entry.time} • ${entry.room}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CampusColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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

class _HubCard extends StatelessWidget {
  const _HubCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: campusCardDecoration(radius: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          // Named route: pushes the screen on top of the Dashboard.
          onTap: () => Navigator.pushNamed(context, route),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CampusColors.navy,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CampusColors.muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
