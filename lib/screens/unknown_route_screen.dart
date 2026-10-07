import 'package:flutter/material.dart';

import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';

/// Fallback used by MaterialApp.onUnknownRoute (404-style screen).
class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key, required this.routeName});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: buildCampusAppBar(context, 'Page not found'),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 84,
                  width: 84,
                  decoration: BoxDecoration(
                    color: CampusColors.pink.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.explore_off_rounded,
                    color: CampusColors.pink,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  '404',
                  style: TextStyle(
                    color: CampusColors.navy,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'We could not open "$routeName".',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: CampusColors.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 22),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Go back'),
                  style: FilledButton.styleFrom(
                    backgroundColor: CampusColors.navy,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(160, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
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
