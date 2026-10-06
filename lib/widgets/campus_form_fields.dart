import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
// SHARED COLOURS
// Same palette that main.dart already uses, so new screens
// look like the rest of CMR Campus Connect.
// ============================================================

class CampusColors {
  static const Color navy = Color(0xFF17182B);
  static const Color blue = Color(0xFF596BFF);
  static const Color purple = Color(0xFF9367FF);
  static const Color pink = Color(0xFFFF6692);
  static const Color mint = Color(0xFF25C9A1);
  static const Color yellow = Color(0xFFFFC85A);
  static const Color background = Color(0xFFF7F7FC);
  static const Color muted = Color(0xFF77798A);

  // Form-specific colours
  static const Color fieldFill = Color(0xFFF3F4FC);
  static const Color fieldBorder = Color(0xFFE3E5F3);
  static const Color error = Color(0xFFE5365B);
}

// ============================================================
// INPUT DECORATION
// One place for borders, focus colour, error style and radius,
// so every field in the app is decorated consistently.
// ============================================================

InputDecoration campusInputDecoration({
  required String label,
  String? hint,
  IconData? icon,
  Widget? suffixIcon,
}) {
  OutlineInputBorder border(Color color, [double width = 1.2]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon:
        icon == null ? null : Icon(icon, size: 20, color: CampusColors.muted),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: CampusColors.fieldFill,
    labelStyle: const TextStyle(
      color: CampusColors.muted,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    floatingLabelStyle: const TextStyle(
      color: CampusColors.blue,
      fontWeight: FontWeight.w800,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFFA3A5B5),
      fontSize: 13,
    ),
    errorStyle: const TextStyle(
      color: CampusColors.error,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    ),
    errorMaxLines: 2,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: border(CampusColors.fieldBorder),
    focusedBorder: border(CampusColors.blue, 2),
    errorBorder: border(CampusColors.error),
    focusedErrorBorder: border(CampusColors.error, 2),
  );
}

// ============================================================
// REUSABLE CampusTextField (advanced option: reusable widget)
// ============================================================

class CampusTextField extends StatelessWidget {
  const CampusTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.hint,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onSaved,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength, // shows a live "x/300" counter when set
      inputFormatters: inputFormatters,
      style: const TextStyle(
        color: CampusColors.navy,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
      decoration: campusInputDecoration(
        label: label,
        hint: hint,
        icon: icon,
      ),
    );
  }
}

// ============================================================
// REUSABLE CampusDropdown (advanced option: reusable widget)
// ============================================================

class CampusDropdown extends StatelessWidget {
  const CampusDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
    required this.validator,
    this.hint,
    this.onSaved,
  });

  final String label;
  final IconData icon;
  final String? hint;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      borderRadius: BorderRadius.circular(16),
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      style: const TextStyle(
        color: CampusColors.navy,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
      hint: hint == null ? null : Text(hint!),
      decoration: campusInputDecoration(label: label, icon: icon),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
