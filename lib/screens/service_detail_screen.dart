import 'package:flutter/material.dart';

import '../models/campus_data.dart';
import '../widgets/campus_app_bar.dart';
import '../widgets/campus_form_fields.dart';

/// Opened through onGenerateRoute (AppRoutes.serviceDetail).
/// Receives a CampusService and returns 'requested' via Navigator.pop.
class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.service});

  final CampusService service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: buildCampusAppBar(context, service.name),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [service.color, service.color.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'service-icon-${service.name}',
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(service.icon, color: service.color, size: 34),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.22),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            service.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
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
                    service.description,
                    style: const TextStyle(
                      color: CampusColors.navy,
                      fontSize: 14,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _infoRow(Icons.place_rounded, 'Location', service.location),
                  _infoRow(
                    Icons.access_time_rounded,
                    'Opening hours',
                    service.openingHours,
                  ),
                  _infoRow(
                    Icons.alternate_email_rounded,
                    'Contact',
                    service.contact,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              // Returns a result to the Services screen.
              onPressed: () => Navigator.pop(context, 'requested'),
              icon: const Icon(Icons.event_available_rounded),
              label: const Text('Request an appointment'),
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
            const SizedBox(height: 10),
            OutlinedButton.icon(
              // Plain pop with no result: reveals Services again.
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Return'),
              style: OutlinedButton.styleFrom(
                foregroundColor: CampusColors.navy,
                side: const BorderSide(color: CampusColors.fieldBorder),
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

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: service.color),
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
