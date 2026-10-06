import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/campus_form_fields.dart';

// ============================================================
// STUDENT HELP REQUEST FORM
// Flutter Form assignment: validated campus service request.
//
// Advanced options used:
//  1. Reusable CampusTextField / CampusDropdown widgets
//  2. Live character counter (request details, max 300)
//  3. Progress indicator for required fields
//  4. Submission summary dialog with request reference
// ============================================================

class ServiceRequestFormScreen extends StatefulWidget {
  const ServiceRequestFormScreen({super.key});

  @override
  State<ServiceRequestFormScreen> createState() =>
      _ServiceRequestFormScreenState();
}

/// Holds the values written by every field's onSaved callback.
class _RequestDraft {
  String name = '';
  String studentId = '';
  String email = '';
  String phone = '';
  String category = '';
  String subject = '';
  String details = '';
  String urgency = '';
  String contact = '';
  DateTime? date;
}

class _ServiceRequestFormScreenState extends State<ServiceRequestFormScreen> {
  // ----------------------------------------------------------
  // FORM KEY: gives access to validate(), save() and reset()
  // ----------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ----------------------------------------------------------
  // CONTROLLERS (disposed in dispose())
  // ----------------------------------------------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  // ----------------------------------------------------------
  // NON-FORM STATE (must also be cleared on reset)
  // ----------------------------------------------------------
  String? _category;
  String? _urgency;
  String? _contactMethod;
  DateTime? _preferredDate;
  bool _declared = false;

  final _RequestDraft _draft = _RequestDraft();

  // ----------------------------------------------------------
  // CUSTOMISATION DATA
  // ----------------------------------------------------------
  static const String _campusEmailDomain = '@cmr.edu.in';
  static const int _minDetailsLength = 20;
  static const int _maxDetailsLength = 300;
  static const int _totalRequiredFields = 10;

  static const List<String> _categories = [
    'Accommodation & Hostel',
    'Academic Office',
    'IT Helpdesk & Wi-Fi',
    'Library Services',
    'Counselling & Wellbeing',
    'Career & Placement',
    'Transport & Facilities',
  ];

  static const List<String> _urgencyLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const Map<String, Color> _urgencyColors = {
    'Low': Color(0xFF18A184),
    'Medium': Color(0xFF596BFF),
    'High': Color(0xFFE07B1A),
    'Critical': Color(0xFFE5365B),
  };

  static const List<String> _contactMethods = [
    'Email',
    'Phone call',
    'WhatsApp',
    'Visit office',
  ];

  static const Map<String, IconData> _contactIcons = {
    'Email': Icons.email_rounded,
    'Phone call': Icons.call_rounded,
    'WhatsApp': Icons.chat_rounded,
    'Visit office': Icons.storefront_rounded,
  };

  // ----------------------------------------------------------
  // LIFECYCLE
  // ----------------------------------------------------------
  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // ============================================================
  // VALIDATORS (specific, helpful messages)
  // ============================================================

  String? _validateName(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return 'Enter your full name.';
    if (value.split(RegExp(r'\s+')).length < 2) {
      return 'Enter your first and last name (at least two words).';
    }
    if (!RegExp(r"^[A-Za-z .'-]+$").hasMatch(value)) {
      return 'Use letters only in your name.';
    }
    return null;
  }

  String? _validateStudentId(String? input) {
    final value = (input ?? '').trim().toUpperCase();
    if (value.isEmpty) return 'Enter your student ID.';
    if (!RegExp(r'^CMR\d{4,8}$').hasMatch(value)) {
      return 'Use CMR followed by 4 to 8 digits, e.g. CMR2026014.';
    }
    return null;
  }

  String? _validateEmail(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return 'Enter your campus email.';
    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Enter a valid email, e.g. name$_campusEmailDomain';
    }
    if (!value.toLowerCase().endsWith(_campusEmailDomain)) {
      return 'Use your campus email ending with $_campusEmailDomain';
    }
    return null;
  }

  String? _validatePhone(String? input) {
    // Optional: only checked when something is typed.
    final value = (input ?? '').replaceAll(' ', '');
    if (value.isEmpty) return null;
    if (!RegExp(r'^\+?\d{10,13}$').hasMatch(value)) {
      return 'Use 10 to 13 digits, with an optional leading +.';
    }
    return null;
  }

  String? _validateCategory(String? value) {
    return value == null ? 'Choose a service category.' : null;
  }

  String? _validateSubject(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return 'Enter a short subject for your request.';
    if (value.length < 5) return 'Subject should be at least 5 characters.';
    return null;
  }

  String? _validateDetails(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return 'Describe what you need help with.';
    if (value.length < _minDetailsLength) {
      return 'Add more detail: ${value.length}/$_minDetailsLength '
          'characters minimum.';
    }
    if (value.length > _maxDetailsLength) {
      return 'Keep the description under $_maxDetailsLength characters.';
    }
    return null;
  }

  String? _validateUrgency(String? value) {
    return value == null ? 'Select an urgency level.' : null;
  }

  String? _validateContact(String? value) {
    return value == null ? 'Select how we should contact you.' : null;
  }

  String? _validateDate(DateTime? value) {
    if (value == null) return 'Pick a preferred response date.';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (value.isBefore(today)) return 'The date cannot be in the past.';
    return null;
  }

  String? _validateDeclaration(bool? value) {
    return value == true ? null : 'Tick the declaration before submitting.';
  }

  // ============================================================
  // PROGRESS (advanced option)
  // ============================================================

  int get _completedRequired {
    var done = 0;
    if (_validateName(_nameController.text) == null) done++;
    if (_validateStudentId(_idController.text) == null) done++;
    if (_validateEmail(_emailController.text) == null) done++;
    if (_validateCategory(_category) == null) done++;
    if (_validateSubject(_subjectController.text) == null) done++;
    if (_validateDetails(_detailsController.text) == null) done++;
    if (_validateUrgency(_urgency) == null) done++;
    if (_validateContact(_contactMethod) == null) done++;
    if (_validateDate(_preferredDate) == null) done++;
    if (_declared) done++;
    return done;
  }

  // ============================================================
  // SUBMIT / RESET
  // ============================================================

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final form = _formKey.currentState;
    if (form == null) return;

    // 1) VALIDATE first. Stay on the form if anything fails.
    if (!form.validate()) {
      _showSnack(
        'Please fix the highlighted fields before submitting.',
        icon: Icons.error_outline_rounded,
        color: CampusColors.error,
      );
      return;
    }

    // 2) SAVE only after every rule passes (runs each onSaved).
    form.save();

    final reference = _generateReference();
    final action = await showDialog<String>(
      context: context,
      builder: (dialogContext) => _buildSuccessDialog(dialogContext, reference),
    );

    if (!mounted) return;
    if (action == 'new') {
      _resetForm();
    } else if (action == 'home') {
      Navigator.of(context).maybePop();
    }
  }

  void _resetForm() {
    // RESET the Form first (clears text fields, dropdown, chips, date,
    // checkbox and hides all error messages)...
    _formKey.currentState?.reset();

    // ...then clear the state that lives outside the Form.
    _nameController.clear();
    _idController.clear();
    _emailController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _detailsController.clear();

    setState(() {
      _category = null;
      _urgency = null;
      _contactMethod = null;
      _preferredDate = null;
      _declared = false;
    });

    _showSnack('Form cleared. Ready for a new request.',
        icon: Icons.refresh_rounded);
  }

  String _generateReference() {
    final now = DateTime.now();
    final tail =
        (now.millisecondsSinceEpoch % 100000).toString().padLeft(5, '0');
    return 'CC-${now.year}-$tail';
  }

  Future<void> _pickDate(FormFieldState<DateTime> field) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: field.value ?? today,
      firstDate: today, // past dates cannot be chosen
      lastDate: today.add(const Duration(days: 60)),
      helpText: 'Preferred response date',
    );

    if (picked == null || !mounted) return;
    field.didChange(picked);
    setState(() => _preferredDate = picked);
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[date.weekday - 1]}, ${date.day} '
        '${months[date.month - 1]} ${date.year}';
  }

  void _showSnack(
    String message, {
    IconData icon = Icons.check_circle_rounded,
    Color color = CampusColors.navy,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CampusColors.background,
      appBar: AppBar(
        backgroundColor: CampusColors.background,
        foregroundColor: CampusColors.navy,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: 'Back',
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
        ),
        title: const Text(
          'Student Help',
          style: TextStyle(
            color: CampusColors.navy,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        // Scrollable body so small screens and the keyboard never overflow.
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
          child: Form(
            key: _formKey,
            // Errors appear after the user touches a field.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // Refresh the progress bar whenever any field changes.
            onChanged: () => setState(() {}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildProgressCard(),
                const SizedBox(height: 16),
                _buildStudentSection(),
                _buildRequestSection(),
                _buildPreferencesSection(),
                _buildConfirmationSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER + PROGRESS
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CampusColors.blue, CampusColors.purple],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: CampusColors.blue.withOpacity(0.25),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: CampusColors.blue,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CMR CAMPUS CONNECT',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Student Help Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tell us what you need and the right campus service unit '
                  'will get back to you.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    final done = _completedRequired;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FORM PROGRESS',
                style: TextStyle(
                  color: CampusColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.6,
                ),
              ),
              Text(
                '$done of $_totalRequiredFields required fields',
                style: const TextStyle(
                  color: CampusColors.navy,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: done / _totalRequiredFields,
              minHeight: 8,
              color: CampusColors.mint,
              backgroundColor: const Color(0xFFE9EAFF),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTIONS
  // ============================================================

  Widget _buildStudentSection() {
    return _SectionCard(
      title: 'Student details',
      subtitle: 'So we know who to reply to',
      icon: Icons.badge_rounded,
      accent: CampusColors.blue,
      children: [
        CampusTextField(
          controller: _nameController,
          label: 'Full name',
          hint: 'e.g. Pranav Ramesh',
          icon: Icons.person_rounded,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          validator: _validateName,
          onSaved: (v) => _draft.name = (v ?? '').trim(),
        ),
        CampusTextField(
          controller: _idController,
          label: 'Student ID',
          hint: 'e.g. CMR2026014',
          icon: Icons.numbers_rounded,
          textCapitalization: TextCapitalization.characters,
          validator: _validateStudentId,
          onSaved: (v) => _draft.studentId = (v ?? '').trim().toUpperCase(),
        ),
        CampusTextField(
          controller: _emailController,
          label: 'Campus email',
          hint: 'name$_campusEmailDomain',
          icon: Icons.alternate_email_rounded,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
          onSaved: (v) => _draft.email = (v ?? '').trim(),
        ),
        CampusTextField(
          controller: _phoneController,
          label: 'Phone (optional)',
          hint: '+91 98765 43210',
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
            LengthLimitingTextInputFormatter(16),
          ],
          validator: _validatePhone,
          onSaved: (v) => _draft.phone = (v ?? '').trim(),
        ),
      ],
    );
  }

  Widget _buildRequestSection() {
    return _SectionCard(
      title: 'Request details',
      subtitle: 'What do you need help with?',
      icon: Icons.edit_note_rounded,
      accent: CampusColors.pink,
      children: [
        CampusDropdown(
          label: 'Service category',
          icon: Icons.category_rounded,
          hint: 'Choose a service unit',
          items: _categories,
          validator: _validateCategory,
          onChanged: (v) => setState(() => _category = v),
          onSaved: (v) => _draft.category = v ?? '',
        ),
        CampusTextField(
          controller: _subjectController,
          label: 'Subject',
          hint: 'e.g. Wi-Fi not working in Block B',
          icon: Icons.title_rounded,
          textCapitalization: TextCapitalization.sentences,
          validator: _validateSubject,
          onSaved: (v) => _draft.subject = (v ?? '').trim(),
        ),
        CampusTextField(
          controller: _detailsController,
          label: 'Request details',
          hint: 'Explain the issue so we can help faster',
          icon: Icons.notes_rounded,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          textCapitalization: TextCapitalization.sentences,
          minLines: 4,
          maxLines: 6,
          maxLength: _maxDetailsLength, // live character counter
          validator: _validateDetails,
          onSaved: (v) => _draft.details = (v ?? '').trim(),
        ),
        _choiceField(
          label: 'Urgency',
          icon: Icons.speed_rounded,
          options: _urgencyLevels,
          colors: _urgencyColors,
          validator: _validateUrgency,
          onPicked: (v) => setState(() => _urgency = v),
          onSaved: (v) => _draft.urgency = v ?? '',
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return _SectionCard(
      title: 'Preferences',
      subtitle: 'How and when should we respond?',
      icon: Icons.tune_rounded,
      accent: CampusColors.mint,
      children: [
        _choiceField(
          label: 'Preferred contact',
          icon: Icons.contact_phone_rounded,
          options: _contactMethods,
          optionIcons: _contactIcons,
          validator: _validateContact,
          onPicked: (v) => setState(() => _contactMethod = v),
          onSaved: (v) => _draft.contact = v ?? '',
        ),
        _buildDateField(),
      ],
    );
  }

  Widget _buildDateField() {
    return FormField<DateTime>(
      validator: _validateDate,
      onSaved: (v) => _draft.date = v,
      builder: (field) {
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _pickDate(field),
          child: InputDecorator(
            isEmpty: field.value == null,
            decoration: campusInputDecoration(
              label: 'Preferred response date',
              icon: Icons.event_rounded,
              suffixIcon: const Icon(
                Icons.calendar_month_rounded,
                color: CampusColors.blue,
              ),
            ).copyWith(errorText: field.errorText),
            child: Text(
              field.value == null ? '' : _formatDate(field.value!),
              style: const TextStyle(
                color: CampusColors.navy,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmationSection() {
    return _SectionCard(
      title: 'Confirmation',
      subtitle: 'Review and send your request',
      icon: Icons.verified_rounded,
      accent: CampusColors.purple,
      children: [
        FormField<bool>(
          initialValue: false,
          validator: _validateDeclaration,
          builder: (field) {
            final hasError = field.hasError;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: CampusColors.fieldFill,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: hasError
                          ? CampusColors.error
                          : CampusColors.fieldBorder,
                      width: hasError ? 2 : 1.2,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: CheckboxListTile(
                      value: field.value ?? false,
                      activeColor: CampusColors.blue,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onChanged: (v) {
                        field.didChange(v);
                        setState(() => _declared = v ?? false);
                      },
                      title: const Text(
                        'I confirm the details above are correct and I agree '
                        'to be contacted by the campus service unit.',
                        style: TextStyle(
                          color: CampusColors.navy,
                          fontSize: 13,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 6),
                    child: Text(
                      field.errorText ?? '',
                      style: const TextStyle(
                        color: CampusColors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: OutlinedButton.icon(
                onPressed: _resetForm,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CampusColors.navy,
                  side: const BorderSide(color: CampusColors.fieldBorder),
                  minimumSize: const Size(0, 54),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send_rounded),
                label: const Text('Submit request'),
                style: FilledButton.styleFrom(
                  backgroundColor: CampusColors.navy,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 54),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // CHIP SELECTOR (used for urgency and contact method)
  // ============================================================

  Widget _choiceField({
    required String label,
    required IconData icon,
    required List<String> options,
    required String? Function(String?) validator,
    required void Function(String) onPicked,
    required void Function(String?) onSaved,
    Map<String, Color>? colors,
    Map<String, IconData>? optionIcons,
  }) {
    return FormField<String>(
      validator: validator,
      onSaved: onSaved,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: CampusColors.muted),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: CampusColors.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final selected = field.value == option;
                final color = colors?[option] ?? CampusColors.blue;
                final optionIcon = optionIcons?[option];

                return ChoiceChip(
                  showCheckmark: false,
                  avatar: optionIcon == null
                      ? null
                      : Icon(
                          optionIcon,
                          size: 17,
                          color: selected ? Colors.white : color,
                        ),
                  label: Text(option),
                  selected: selected,
                  selectedColor: color,
                  backgroundColor: CampusColors.fieldFill,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : CampusColors.navy,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: selected ? color : CampusColors.fieldBorder,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  onSelected: (_) {
                    field.didChange(option);
                    onPicked(option);
                  },
                );
              }).toList(),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 6),
                child: Text(
                  field.errorText ?? '',
                  style: const TextStyle(
                    color: CampusColors.error,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // ============================================================
  // SUCCESS DIALOG (summary + reference number)
  // ============================================================

  Widget _buildSuccessDialog(BuildContext dialogContext, String reference) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: CampusColors.mint.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: CampusColors.mint,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Center(
              child: Text(
                'Request sent!',
                style: TextStyle(
                  color: CampusColors.navy,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Reference: $reference',
                style: const TextStyle(
                  color: CampusColors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'The ${_draft.category} team will reach out via '
                '${_draft.contact.toLowerCase()}.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CampusColors.muted,
                  fontSize: 12,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CampusColors.fieldFill,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _summaryRow('Student', _draft.name),
                  _summaryRow('ID', _draft.studentId),
                  _summaryRow('Email', _draft.email),
                  if (_draft.phone.isNotEmpty)
                    _summaryRow('Phone', _draft.phone),
                  _summaryRow('Service', _draft.category),
                  _summaryRow('Subject', _draft.subject),
                  _summaryRow('Urgency', _draft.urgency),
                  _summaryRow('Contact', _draft.contact),
                  if (_draft.date != null)
                    _summaryRow('Date', _formatDate(_draft.date!)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop('new'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CampusColors.navy,
                      side: const BorderSide(color: CampusColors.fieldBorder),
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('New request'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(dialogContext).pop('home'),
                    style: FilledButton.styleFrom(
                      backgroundColor: CampusColors.navy,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: CampusColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: CampusColors.navy,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}

// ============================================================
// SECTION CARD (groups related fields under a heading)
// ============================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.children,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: accent, size: 21),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: CampusColors.navy,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: CampusColors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            children.length * 2 - 1,
            (i) => i.isEven ? children[i ~/ 2] : const SizedBox(height: 14),
          ),
        ],
      ),
    );
  }
}
