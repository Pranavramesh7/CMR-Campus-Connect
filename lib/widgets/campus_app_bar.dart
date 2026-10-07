import 'package:flutter/material.dart';

import 'campus_form_fields.dart';

/// App bar shared by every pushed route so they all look the same.
/// The back button only appears when Navigator.canPop() is true.
PreferredSizeWidget buildCampusAppBar(BuildContext context, String title) {
  final canPop = Navigator.of(context).canPop();

  return AppBar(
    backgroundColor: CampusColors.background,
    foregroundColor: CampusColors.navy,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    automaticallyImplyLeading: false,
    leading: canPop
        ? IconButton(
            tooltip: 'Back',
            // Pops the current route; never pushes a second Dashboard.
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: CampusColors.navy,
                size: 20,
              ),
            ),
          )
        : null,
    title: Text(
      title,
      style: const TextStyle(
        color: CampusColors.navy,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
    ),
  );
}

BoxDecoration campusCardDecoration({double radius = 22}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
