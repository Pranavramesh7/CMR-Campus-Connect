import 'package:flutter/material.dart';

import '../models/campus_data.dart';
import '../routes/app_routes.dart';
import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';
import '../widgets/campus_hub_section.dart';

/// Named route: AppRoutes.services
/// Opens Service Details with the tapped CampusService as an argument
/// and shows a SnackBar when the details route returns a result.
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // Blocks rapid repeated taps from pushing duplicate routes.
  bool _opening = false;

  Future<void> _openService(CampusService service) async {
    if (_opening) return;
    _opening = true;

    // Send the selected object and wait for the result from pop().
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.serviceDetail,
      arguments: service,
    );

    _opening = false;

    // Never use context after an await without checking it.
    if (!context.mounted) return;

    if (result == 'requested') {
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
              'Appointment request sent to ${service.name}.',
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
      appBar: buildCampusAppBar(context, 'Campus Services'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            const CampusPhotoBanner(
              title: 'How can we help?',
              subtitle: 'Tap a service to see hours, location and contact',
              height: 130,
            ),
            const SizedBox(height: 16),
            for (final service in campusServices)
              _ServiceTile(
                service: service,
                onTap: () => _openService(service),
              ),
          ],
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.service, required this.onTap});

  final CampusService service;
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
                // Hero: the icon flies into the details screen.
                Hero(
                  tag: 'service-icon-${service.name}',
                  child: Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      color: service.color.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Icon(service.icon, color: service.color, size: 28),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                          color: CampusColors.navy,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        service.summary,
                        style: const TextStyle(
                          color: CampusColors.muted,
                          fontSize: 12,
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
