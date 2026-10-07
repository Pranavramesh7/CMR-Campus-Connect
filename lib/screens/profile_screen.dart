import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';

/// Named route: AppRoutes.profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: buildCampusAppBar(context, 'My Profile'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [CampusColors.blue, CampusColors.purple],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  Container(
                    height: 84,
                    width: 84,
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/cmr_mark.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'PR',
                            style: TextStyle(
                              color: CampusColors.navy,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Pranav R',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'CMR University',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: campusCardDecoration(),
              child: const Column(
                children: [
                  _InfoTile(Icons.badge_rounded, 'Student ID', 'CMR2026001'),
                  _InfoTile(
                    Icons.school_rounded,
                    'Programme',
                    'BTech Computer Science & Technology',
                  ),
                  _InfoTile(Icons.layers_rounded, 'Semester', 'Semester 1'),
                  _InfoTile(
                    Icons.alternate_email_rounded,
                    'Email',
                    'pranav.r@cmr.edu.in',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              // Named route to the Student Help form.
              onPressed: () => Navigator.pushNamed(context, AppRoutes.studentHelp),
              icon: const Icon(Icons.support_agent_rounded),
              label: const Text('Open Student Help'),
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
            const SizedBox(height: 6),
            TextButton(
              // Test case T8: an unregistered route shows the 404 screen.
              onPressed: () =>
                  Navigator.pushNamed(context, '/test-unknown-route'),
              child: const Text('Test unknown route'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: CampusColors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: CampusColors.muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: CampusColors.navy,
                    fontSize: 14,
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
