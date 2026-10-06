import 'dart:async';
import 'package:flutter/material.dart';

import 'screens/service_request_form_screen.dart';

void main() {
  runApp(const CMRCampusApp());
}

// ============================================================
// CMR CAMPUS CONNECT
// Premium + Colourful UI
// ============================================================

class CMRCampusApp extends StatelessWidget {
  const CMRCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMR Campus Connect',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF7F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5C6CFF),
          brightness: Brightness.light,
        ),
      ),
      home: const CampusHomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class CampusHomePage extends StatefulWidget {
  const CampusHomePage({super.key});

  @override
  State<CampusHomePage> createState() => _CampusHomePageState();
}

class _CampusHomePageState extends State<CampusHomePage> {
  // ----------------------------------------------------------
  // COLORS
  // ----------------------------------------------------------

  static const Color navy = Color(0xFF17182B);
  static const Color blue = Color(0xFF596BFF);
  static const Color purple = Color(0xFF9367FF);
  static const Color pink = Color(0xFFFF6692);
  static const Color mint = Color(0xFF25C9A1);
  static const Color yellow = Color(0xFFFFC85A);
  static const Color background = Color(0xFFF7F7FC);
  static const Color muted = Color(0xFF77798A);

  // ----------------------------------------------------------
  // NAVIGATION
  // ----------------------------------------------------------

  int currentIndex = 0;

  // ----------------------------------------------------------
  // HOME STATE
  // ----------------------------------------------------------

  int reminderCount = 0;

  final List<String> registeredActivities = [];

  // ----------------------------------------------------------
  // DISCOVERY STATE
  // ----------------------------------------------------------

  int discoveryIndex = 0;
  Offset discoveryDragOffset = Offset.zero;
  bool discoveryAnimating = false;

  final List<Map<String, dynamic>> discoveryItems = [
    {
      'title': 'Coding Club Meetup',
      'subtitle': 'Build • Learn • Connect',
      'date': '26 SEP',
      'time': '2:00 PM',
      'location': 'Computer Lab',
      'type': 'CLUB',
      'icon': Icons.code_rounded,
      'colors': [
        Color(0xFF596BFF),
        Color(0xFF8E67FF),
      ],
      'description':
          'A relaxed coding session where students build projects, share ideas and meet other developers.',
    },
    {
      'title': 'Design Sprint Night',
      'subtitle': 'Create something different',
      'date': '27 SEP',
      'time': '6:30 PM',
      'location': 'Innovation Lab',
      'type': 'WORKSHOP',
      'icon': Icons.auto_awesome_rounded,
      'colors': [
        Color(0xFFFF5E8A),
        Color(0xFFFF8B6A),
      ],
      'description':
          'A creative design challenge focused on ideas, prototypes and solving real student problems.',
    },
    {
      'title': 'Campus Sports Day',
      'subtitle': 'Compete • Cheer • Enjoy',
      'date': '28 SEP',
      'time': '9:00 AM',
      'location': 'Sports Ground',
      'type': 'SPORTS',
      'icon': Icons.sports_soccer_rounded,
      'colors': [
        Color(0xFF18B998),
        Color(0xFF62D5A8),
      ],
      'description':
          'A full campus sports day with team events, friendly competitions and plenty of student energy.',
    },
    {
      'title': 'Career Preparation',
      'subtitle': 'Get ready for the real world',
      'date': '30 SEP',
      'time': '11:30 AM',
      'location': 'Seminar Hall',
      'type': 'CAREER',
      'icon': Icons.rocket_launch_rounded,
      'colors': [
        Color(0xFF7B61FF),
        Color(0xFFB66DFF),
      ],
      'description':
          'Practical preparation for interviews, professional communication and building a strong student profile.',
    },
    {
      'title': 'Innovation Lab Open House',
      'subtitle': 'Explore • Experiment • Imagine',
      'date': '02 OCT',
      'time': '1:00 PM',
      'location': 'Innovation Lab',
      'type': 'DISCOVER',
      'icon': Icons.lightbulb_rounded,
      'colors': [
        Color(0xFFFFB52E),
        Color(0xFFFFD76A),
      ],
      'description':
          'Explore student projects, creative technologies and interesting experiments happening around campus.',
    },
  ];

  final Set<String> interestedDiscoveryItems = {};

  // ----------------------------------------------------------
  // MISSIONS
  // ----------------------------------------------------------

  final List<Map<String, dynamic>> missions = [
    {
      'title': 'Try something new',
      'description': 'Discover one campus activity today.',
      'icon': Icons.explore_rounded,
      'color': blue,
      'completed': false,
    },
    {
      'title': 'Meet your people',
      'description': 'Check out one student club.',
      'icon': Icons.groups_rounded,
      'color': pink,
      'completed': false,
    },
    {
      'title': 'Make time to focus',
      'description': 'Spend 20 minutes studying.',
      'icon': Icons.menu_book_rounded,
      'color': mint,
      'completed': false,
    },
  ];

  // ----------------------------------------------------------
  // STUDY HUB STATE
  // ----------------------------------------------------------

  int studyCardIndex = 0;
  bool studyCardRevealed = false;

  final List<Map<String, String>> memoryCards = [
    {
      'front': 'What does Flutter build?',
      'back': 'Beautiful multi-platform apps from one codebase.',
    },
    {
      'front': 'What language does Flutter use?',
      'back': 'Dart.',
    },
    {
      'front': 'What does setState do?',
      'back': 'It tells Flutter that the widget state changed.',
    },
    {
      'front': 'What is a Scaffold?',
      'back': 'A structure for common Material app screen layouts.',
    },
  ];

  // ----------------------------------------------------------
  // FOCUS TIMER
  // ----------------------------------------------------------

  Timer? focusTimer;
  int focusSeconds = 20 * 60;
  bool focusRunning = false;

  // ----------------------------------------------------------
  // EVENTS
  // ----------------------------------------------------------

  final List<Map<String, String>> activities = [
    {
      'title': 'Tech Innovation Workshop',
      'date': '24 Sep 2026',
      'time': '10:00 AM',
      'location': 'Innovation Lab',
      'type': 'WORKSHOP',
    },
    {
      'title': 'Coding Club Meetup',
      'date': '26 Sep 2026',
      'time': '2:00 PM',
      'location': 'Computer Lab',
      'type': 'CLUB',
    },
    {
      'title': 'Campus Sports Day',
      'date': '28 Sep 2026',
      'time': '9:00 AM',
      'location': 'Sports Ground',
      'type': 'SPORTS',
    },
    {
      'title': 'Career Preparation Session',
      'date': '30 Sep 2026',
      'time': '11:30 AM',
      'location': 'Seminar Hall',
      'type': 'CAREER',
    },
  ];

  String selectedEventFilter = 'ALL';

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void dispose() {
    focusTimer?.cancel();
    super.dispose();
  }

  // ============================================================
  // NAVIGATION HELPERS
  // ============================================================

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void changePageFromDrawer(int index) {
    Navigator.pop(context);

    setState(() {
      currentIndex = index;
    });
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void showPremiumSnack(
    String message, {
    IconData icon = Icons.check_circle_rounded,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        backgroundColor: navy,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        content: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 19,
              ),
            ),
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
  // EVENT REGISTER
  // ============================================================

  void registerForActivity(String title) {
    if (registeredActivities.contains(title)) {
      showPremiumSnack(
        'You are already registered for this event.',
        icon: Icons.info_rounded,
      );
      return;
    }

    setState(() {
      registeredActivities.add(title);
    });

    showPremiumSnack(
      '$title added to your campus plans.',
      icon: Icons.event_available_rounded,
    );
  }

  // ============================================================
  // REMINDER
  // ============================================================

  void addReminder() {
    setState(() {
      reminderCount++;
    });

    showPremiumSnack(
      'Reminder added to your day.',
      icon: Icons.notifications_active_rounded,
    );
  }

  // ============================================================
  // MISSION SHEET
  // ============================================================

  void openMissionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDADAE4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Row(
                      children: [
                        Text(
                          'TODAY',
                          style: TextStyle(
                            color: blue,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.flag_rounded,
                          color: pink,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Campus Missions',
                      style: TextStyle(
                        color: navy,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Small actions. Better campus days.',
                      style: TextStyle(
                        color: muted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...missions.asMap().entries.map(
                      (entry) {
                        final mission = entry.value;
                        final color = mission['color'] as Color;
                        final completed = mission['completed'] as bool;

                        return GestureDetector(
                          onTap: completed
                              ? null
                              : () {
                                  setState(() {
                                    mission['completed'] = true;
                                  });

                                  setSheetState(() {});

                                  showPremiumSnack(
                                    'Mission complete: ${mission['title']}',
                                    icon: Icons.celebration_rounded,
                                  );
                                },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: completed
                                  ? const Color(0xFFF2F4F8)
                                  : color.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: completed
                                    ? const Color(0xFFE0E2EA)
                                    : color.withOpacity(0.25),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    gradient: completed
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFFB8BDC8),
                                              Color(0xFF8E94A0),
                                            ],
                                          )
                                        : LinearGradient(
                                            colors: [
                                              color,
                                              color.withOpacity(0.72),
                                            ],
                                          ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    completed
                                        ? Icons.check_rounded
                                        : mission['icon'] as IconData,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 13),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mission['title'] as String,
                                        style: TextStyle(
                                          color: completed
                                              ? const Color(0xFF7D818E)
                                              : navy,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          decoration: completed
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        mission['description'] as String,
                                        style: const TextStyle(
                                          color: muted,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  completed
                                      ? Icons.check_circle_rounded
                                      : Icons.arrow_forward_ios_rounded,
                                  color: completed ? mint : color,
                                  size: completed ? 23 : 15,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // DISCOVERY SWIPE
  // ============================================================

  void completeDiscoverySwipe(bool interested) {
    if (discoveryAnimating) return;

    final current = discoveryItems[discoveryIndex];
    final title = current['title'] as String;

    setState(() {
      discoveryAnimating = true;
      discoveryDragOffset = Offset(
        interested ? 700 : -700,
        0,
      );

      if (interested) {
        interestedDiscoveryItems.add(title);
      }
    });

    Future.delayed(const Duration(milliseconds: 230), () {
      if (!mounted) return;

      setState(() {
        discoveryIndex =
            (discoveryIndex + 1) % discoveryItems.length;
        discoveryDragOffset = Offset.zero;
        discoveryAnimating = false;
      });

      if (interested) {
        showPremiumSnack(
          '$title saved to your picks.',
          icon: Icons.favorite_rounded,
        );
      }
    });
  }

  void onDiscoveryDragUpdate(DragUpdateDetails details) {
    if (discoveryAnimating) return;

    setState(() {
      discoveryDragOffset += details.delta;
    });
  }

  void onDiscoveryDragEnd(DragEndDetails details) {
    if (discoveryAnimating) return;

    if (discoveryDragOffset.dx > 120) {
      completeDiscoverySwipe(true);
    } else if (discoveryDragOffset.dx < -120) {
      completeDiscoverySwipe(false);
    } else {
      setState(() {
        discoveryDragOffset = Offset.zero;
      });
    }
  }

  // ============================================================
  // FOCUS TIMER
  // ============================================================

  void toggleFocusTimer() {
    if (focusRunning) {
      focusTimer?.cancel();

      setState(() {
        focusRunning = false;
      });

      showPremiumSnack(
        'Focus timer paused.',
        icon: Icons.pause_circle_rounded,
      );

      return;
    }

    focusTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return;

        if (focusSeconds <= 0) {
          timer.cancel();

          setState(() {
            focusRunning = false;
            focusSeconds = 20 * 60;
          });

          showPremiumSnack(
            'Focus session complete. Nice work.',
            icon: Icons.auto_awesome_rounded,
          );
        } else {
          setState(() {
            focusSeconds--;
          });
        }
      },
    );

    setState(() {
      focusRunning = true;
    });

    showPremiumSnack(
      'Focus session started.',
      icon: Icons.timer_rounded,
    );
  }

  void resetFocusTimer() {
    focusTimer?.cancel();

    setState(() {
      focusRunning = false;
      focusSeconds = 20 * 60;
    });
  }

  String get formattedFocusTime {
    final minutes =
        (focusSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds =
        (focusSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  // ============================================================
  // DISCOVERY CARD
  // ============================================================

  Widget _buildDiscoveryCard(
    Map<String, dynamic> item,
    int position,
  ) {
    final List<Color> colors = item['colors'] as List<Color>;

    final depth = position;

    final double scale = depth == 0
        ? 1
        : depth == 1
            ? 0.95
            : 0.90;

    final double yOffset = depth == 0
        ? 0
        : depth == 1
            ? 18
            : 34;

    final double rotation = depth == 0
        ? discoveryDragOffset.dx / 700
        : 0;

    final double xOffset =
        depth == 0 ? discoveryDragOffset.dx : 0;

    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.only(top: yOffset),
        child: IgnorePointer(
          ignoring: depth != 0 || discoveryAnimating,
          child: GestureDetector(
            onPanUpdate: onDiscoveryDragUpdate,
            onPanEnd: onDiscoveryDragEnd,
            child: AnimatedContainer(
              duration: depth == 0 && discoveryDragOffset != Offset.zero
                  ? const Duration(milliseconds: 0)
                  : const Duration(milliseconds: 260),
              curve: Curves.easeOutBack,
              transform: Matrix4.identity()
                ..translate(xOffset)
                ..rotateZ(rotation)
                ..scale(scale),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
                borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                    color: colors.first.withOpacity(0.28),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -45,
                    right: -30,
                    child: _decorativeCircle(
                      size: 150,
                      color: Colors.white.withOpacity(0.09),
                    ),
                  ),
                  Positioned(
                    bottom: -35,
                    left: -20,
                    child: _decorativeCircle(
                      size: 110,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: Text(
                        item['type'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      28,
                      30,
                      28,
                      26,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.16),
                            ),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item['date'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['subtitle'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Colors.white,
                              size: 17,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              item['time'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 17,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                item['location'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (depth == 0 && discoveryDragOffset.dx.abs() > 50)
                    Positioned(
                      top: 90,
                      left: discoveryDragOffset.dx > 0 ? null : 25,
                      right: discoveryDragOffset.dx > 0 ? 25 : null,
                      child: Transform.rotate(
                        angle: discoveryDragOffset.dx > 0
                            ? -0.10
                            : 0.10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            discoveryDragOffset.dx > 0
                                ? 'INTERESTED'
                                : 'PASS',
                            style: TextStyle(
                              color: discoveryDragOffset.dx > 0
                                  ? mint
                                  : pink,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _decorativeCircle({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: currentIndex,
        children: [
          _buildHomePage(),
          _buildDiscoverPage(),
          _buildStudyPage(),
          _buildEventsPage(),
          _buildProfilePage(),
        ],
      ),
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: openMissionSheet,
              backgroundColor: navy,
              foregroundColor: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              child: const Icon(
                Icons.flag_rounded,
                size: 24,
              ),
            )
          : currentIndex == 3
              ? FloatingActionButton(
                  onPressed: addReminder,
                  backgroundColor: pink,
                  foregroundColor: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                  ),
                )
              : null,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  PreferredSizeWidget _buildAppBar() {
    final titles = [
      'CMR Campus Connect',
      'Discover',
      'Study Hub',
      'Events',
      'Profile',
    ];

    return AppBar(
      backgroundColor: background,
      foregroundColor: navy,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
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
                Icons.menu_rounded,
                color: navy,
                size: 22,
              ),
            ),
          );
        },
      ),
      title: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: blue.withOpacity(0.10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              'assets/cmr_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    'CMR',
                    style: TextStyle(
                      color: blue,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              titles[currentIndex],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: navy,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: addReminder,
              icon: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: navy,
                  size: 21,
                ),
              ),
            ),
            if (reminderCount > 0)
              Positioned(
                right: 5,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: pink,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: background,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '$reminderCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: changePage,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 18,
      selectedItemColor: navy,
      unselectedItemColor: const Color(0xFF9698A7),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
      items: [
        _bottomItem(
          Icons.home_outlined,
          Icons.home_rounded,
          'Home',
          0,
        ),
        _bottomItem(
          Icons.explore_outlined,
          Icons.explore_rounded,
          'Discover',
          1,
        ),
        _bottomItem(
          Icons.auto_stories_outlined,
          Icons.auto_stories_rounded,
          'Study',
          2,
        ),
        _bottomItem(
          Icons.calendar_month_outlined,
          Icons.calendar_month_rounded,
          'Events',
          3,
        ),
        _bottomItem(
          Icons.person_outline_rounded,
          Icons.person_rounded,
          'Profile',
          4,
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomItem(
    IconData icon,
    IconData selectedIcon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Icon(
          currentIndex == index ? selectedIcon : icon,
          size: 23,
        ),
      ),
      label: label,
    );
  }

  // ============================================================
  // HOME
  // ============================================================

  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(),
            const SizedBox(height: 20),
            _buildDiscoverHero(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 26),
            _buildMissionPreview(),
            const SizedBox(height: 26),
            _buildUpcomingPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GOOD AFTERNOON',
                style: TextStyle(
                  color: muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.8,
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: navy,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(text: 'Hey, '),
                    TextSpan(
                      text: 'Pranav',
                      style: TextStyle(
                        color: blue,
                      ),
                    ),
                    TextSpan(text: ' 👋'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Ready to explore campus?',
                style: TextStyle(
                  color: muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                blue,
                purple,
              ],
            ),
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: blue.withOpacity(0.25),
                blurRadius: 15,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Image.asset(
              'assets/cmr_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    'CMR',
                    style: TextStyle(
                      color: navy,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverHero() {
    return GestureDetector(
      onTap: () {
        changePage(1);
      },
      child: Container(
        height: 235,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              blue,
              Color(0xFF6B5DFE),
              purple,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.27),
              blurRadius: 28,
              offset: const Offset(0, 13),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -45,
              right: -25,
              child: _decorativeCircle(
                size: 155,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            Positioned(
              bottom: -55,
              left: -30,
              child: _decorativeCircle(
                size: 155,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
            Positioned(
              top: 22,
              right: 22,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.swipe_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'SWIPE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(23, 23, 23, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CAMPUS DISCOVER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                    ),
                  ),
                  SizedBox(height: 9),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Find something worth showing up for.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 17,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Events • Clubs • Workshops',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 21,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // QUICK ACTIONS
  // ============================================================

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QUICK ACCESS',
          style: TextStyle(
            color: muted,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 11),
        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                title: 'Study',
                subtitle: 'Focus & recall',
                icon: Icons.auto_stories_rounded,
                colorA: const Color(0xFF7A65FF),
                colorB: const Color(0xFFAA83FF),
                onTap: () => changePage(2),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: _quickActionCard(
                title: 'Missions',
                subtitle: 'Do something new',
                icon: Icons.flag_rounded,
                colorA: const Color(0xFFFF638E),
                colorB: const Color(0xFFFF906E),
                onTap: openMissionSheet,
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                title: 'Events',
                subtitle: 'See what’s next',
                icon: Icons.calendar_month_rounded,
                colorA: const Color(0xFF20B99A),
                colorB: const Color(0xFF5FD5A7),
                onTap: () => changePage(3),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: _quickActionCard(
                title: 'Discover',
                subtitle: 'Swipe & explore',
                icon: Icons.explore_rounded,
                colorA: const Color(0xFF5681FF),
                colorB: const Color(0xFF69B4FF),
                onTap: () => changePage(1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color colorA,
    required Color colorB,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          height: 128,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorA,
                colorB,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorA.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -25,
                bottom: -30,
                child: _decorativeCircle(
                  size: 95,
                  color: Colors.white.withOpacity(0.10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
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
    );
  }

  // ============================================================
  // MISSION PREVIEW
  // ============================================================

  Widget _buildMissionPreview() {
    final mission = missions.firstWhere(
      (item) => item['completed'] == false,
      orElse: () => missions.first,
    );

    final Color color = mission['color'] as Color;

    return GestureDetector(
      onTap: openMissionSheet,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(19),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.10),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.65),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                mission['icon'] as IconData,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TODAY’S MISSION',
                    style: TextStyle(
                      color: muted,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mission['title'] as String,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mission['description'] as String,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: navy,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // UPCOMING EVENTS PREVIEW
  // ============================================================

  Widget _buildUpcomingPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'UP NEXT',
                style: TextStyle(
                  color: muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            TextButton(
              onPressed: () => changePage(3),
              child: const Text(
                'See all',
                style: TextStyle(
                  color: blue,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        ...activities.take(2).map(_buildCompactEvent),
      ],
    );
  }

  Widget _buildCompactEvent(Map<String, String> activity) {
    final String type = activity['type']!;

    final Color accent = _eventAccent(type);

    return GestureDetector(
      onTap: () => registerForActivity(activity['title']!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: const Color(0xFFE9E9F0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 59,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.10),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activity['date']!.split(' ')[0],
                    style: TextStyle(
                      color: accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    activity['date']!.split(' ')[1].toUpperCase(),
                    style: TextStyle(
                      color: accent,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['title']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activity['time']!,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xFF9B9DAC),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DISCOVER PAGE
  // ============================================================

  Widget _buildDiscoverPage() {
    final item = discoveryItems[discoveryIndex];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 5, 18, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SWIPE. SAVE. EXPLORE.',
              style: TextStyle(
                color: blue,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'What’s your vibe?',
              style: TextStyle(
                color: navy,
                fontSize: 29,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Swipe through things happening around campus.',
              style: TextStyle(
                color: muted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 430,
              child: Stack(
                children: [
                  _buildDiscoveryCard(
                    discoveryItems[
                        (discoveryIndex + 2) % discoveryItems.length],
                    2,
                  ),
                  _buildDiscoveryCard(
                    discoveryItems[
                        (discoveryIndex + 1) % discoveryItems.length],
                    1,
                  ),
                  _buildDiscoveryCard(
                    item,
                    0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _swipeButton(
                  icon: Icons.close_rounded,
                  color: pink,
                  onTap: () => completeDiscoverySwipe(false),
                ),
                const SizedBox(width: 28),
                _swipeButton(
                  icon: Icons.favorite_rounded,
                  color: mint,
                  size: 66,
                  onTap: () => completeDiscoverySwipe(true),
                ),
                const SizedBox(width: 28),
                _swipeButton(
                  icon: Icons.info_outline_rounded,
                  color: blue,
                  onTap: () {
                    _showDiscoveryDetails(item);
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                discoveryItems.length,
                (index) {
                  final active = index == discoveryIndex;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    width: active ? 20 : 6,
                    decoration: BoxDecoration(
                      color: active
                          ? blue
                          : const Color(0xFFD7D8E1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            _buildPicksBanner(),
          ],
        ),
      ),
    );
  }

  Widget _swipeButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    double size = 58,
  }) {
    return GestureDetector(
      onTap: discoveryAnimating ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: color.withOpacity(0.18),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: size > 60 ? 27 : 23,
        ),
      ),
    );
  }

  Widget _buildPicksBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFEDF3),
            pink.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: pink.withOpacity(0.16),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: pink.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: pink,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR PICKS',
                  style: TextStyle(
                    color: muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${interestedDiscoveryItems.length} things saved so far',
                  style: const TextStyle(
                    color: navy,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDiscoveryDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        final colors = item['colors'] as List<Color>;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                  width: 45,
                  margin: const EdgeInsets.only(
                    bottom: 22,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDADAE4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['description'] as String,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _detailPill(
                      Icons.calendar_today_rounded,
                      item['date'] as String,
                    ),
                    const SizedBox(width: 8),
                    _detailPill(
                      Icons.access_time_rounded,
                      item['time'] as String,
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                _detailPill(
                  Icons.location_on_rounded,
                  item['location'] as String,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      completeDiscoverySwipe(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: const Text(
                      'SAVE TO MY PICKS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailPill(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 1),
          Icon(
            icon,
            size: 14,
            color: navy,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: navy,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STUDY PAGE
  // ============================================================

  Widget _buildStudyPage() {
    final card = memoryCards[studyCardIndex];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 5, 18, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'STUDY SMARTER',
              style: TextStyle(
                color: purple,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Your study space.',
              style: TextStyle(
                color: navy,
                fontSize: 29,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Recall, focus and keep moving.',
              style: TextStyle(
                color: muted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 22),
            _buildMemoryCard(card),
            const SizedBox(height: 18),
            _buildMemoryControls(),
            const SizedBox(height: 30),
            _buildFocusTimer(),
            const SizedBox(height: 25),
            _buildStudyTools(),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryCard(Map<String, String> card) {
    return GestureDetector(
      onTap: () {
        setState(() {
          studyCardRevealed = !studyCardRevealed;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        height: 250,
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: studyCardRevealed
                ? const [
                    Color(0xFF242340),
                    Color(0xFF5446A9),
                  ]
                : const [
                    Color(0xFF7865FF),
                    Color(0xFFA16FFF),
                  ],
          ),
          borderRadius: BorderRadius.circular(31),
          boxShadow: [
            BoxShadow(
              color: purple.withOpacity(0.22),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -35,
              top: -35,
              child: _decorativeCircle(
                size: 130,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'CARD ${studyCardIndex + 1}/${memoryCards.length}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.touch_app_rounded,
                      color: Colors.white70,
                      size: 19,
                    ),
                  ],
                ),
                const Spacer(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    studyCardRevealed
                        ? card['back']!
                        : card['front']!,
                    key: ValueKey(
                      '${studyCardIndex}_$studyCardRevealed',
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: studyCardRevealed ? 20 : 27,
                      fontWeight: FontWeight.w900,
                      height: 1.12,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  studyCardRevealed
                      ? 'TAP TO HIDE ANSWER'
                      : 'TAP TO REVEAL',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              studyCardIndex =
                  (studyCardIndex - 1 + memoryCards.length) %
                      memoryCards.length;
              studyCardRevealed = false;
            });
          },
          child: _studyControl(
            Icons.arrow_back_rounded,
          ),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            setState(() {
              studyCardIndex =
                  (studyCardIndex + 1) % memoryCards.length;
              studyCardRevealed = false;
            });
          },
          child: _studyControl(
            Icons.arrow_forward_rounded,
          ),
        ),
      ],
    );
  }

  Widget _studyControl(IconData icon) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: navy,
        size: 20,
      ),
    );
  }

  Widget _buildFocusTimer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE5FFF8),
            Color(0xFFD5FFF1),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: mint.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                formattedFocusTime,
                style: const TextStyle(
                  color: navy,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FOCUS SESSION',
                  style: TextStyle(
                    color: mint,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  focusRunning
                      ? 'Stay in the zone.'
                      : 'Ready when you are.',
                  style: const TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    GestureDetector(
                      onTap: toggleFocusTimer,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: navy,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text(
                          focusRunning ? 'PAUSE' : 'START',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: resetFocusTimer,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyTools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MORE TOOLS',
          style: TextStyle(
            color: muted,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 11),
        Row(
          children: [
            Expanded(
              child: _studyToolCard(
                'Quick Quiz',
                'Test yourself',
                Icons.bolt_rounded,
                const Color(0xFF5A7DFF),
                () {
                  _showQuickQuiz();
                },
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: _studyToolCard(
                'Notes',
                'Your thoughts',
                Icons.edit_note_rounded,
                const Color(0xFFFFB740),
                () {
                  showPremiumSnack(
                    'Notes space opened.',
                    icon: Icons.edit_note_rounded,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _studyToolCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 115,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: color.withOpacity(0.13),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 39,
              width: 39,
              decoration: BoxDecoration(
                color: color.withOpacity(0.11),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: muted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickQuiz() {
    int selected = -1;
    const answers = [
      'A programming language',
      'A database',
      'A browser',
      'An operating system',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(31),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateQuiz) {
            final answered = selected != -1;

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 5,
                      margin: const EdgeInsets.only(
                        bottom: 22,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDADAE4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const Text(
                      'QUICK QUIZ',
                      style: TextStyle(
                        color: blue,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Dart is...',
                      style: TextStyle(
                        color: navy,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...answers.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final text = entry.value;
                        final isSelected = selected == index;
                        final isCorrect = index == 0;

                        Color borderColor =
                            const Color(0xFFE8E8EF);

                        Color backgroundColor = Colors.white;

                        if (answered && isSelected) {
                          borderColor =
                              isCorrect ? mint : pink;

                          backgroundColor =
                              isCorrect
                                  ? mint.withOpacity(0.08)
                                  : pink.withOpacity(0.08);
                        }

                        return GestureDetector(
                          onTap: answered
                              ? null
                              : () {
                                  setStateQuiz(() {
                                    selected = index;
                                  });
                                },
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius:
                                  BorderRadius.circular(16),
                              border: Border.all(
                                color: borderColor,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? borderColor
                                        : const Color(
                                            0xFFF1F1F6,
                                          ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(
                                        65 + index,
                                      ),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : muted,
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                      color: navy,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                if (answered && isSelected)
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle_rounded
                                        : Icons.cancel_rounded,
                                    color: borderColor,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (answered)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: selected == 0
                              ? mint.withOpacity(0.08)
                              : pink.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          selected == 0
                              ? 'Correct. Dart is the language used by Flutter.'
                              : 'Not quite. Dart is the programming language used by Flutter.',
                          style: TextStyle(
                            color:
                                selected == 0 ? mint : pink,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // EVENTS PAGE
  // ============================================================

  Widget _buildEventsPage() {
    final filteredActivities = activities.where(
      (activity) {
        if (selectedEventFilter == 'ALL') {
          return true;
        }

        return activity['type'] == selectedEventFilter;
      },
    ).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 5, 18, 110),
        children: [
          _buildEventsHero(),
          const SizedBox(height: 20),
          _buildEventFilters(),
          const SizedBox(height: 16),
          ...filteredActivities.map(_buildPremiumEventCard),
        ],
      ),
    );
  }

  Widget _buildEventsHero() {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF18B99B),
            Color(0xFF54D9A4),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: mint.withOpacity(0.22),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -25,
            bottom: -30,
            child: _decorativeCircle(
              size: 125,
              color: Colors.white.withOpacity(0.10),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CAMPUS CALENDAR',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.6,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Something is\nalways happening.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  height: 1.02,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Pick a date. Pick a vibe.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventFilters() {
    final filters = [
      'ALL',
      'CLUB',
      'WORKSHOP',
      'SPORTS',
      'CAREER',
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = filter == selectedEventFilter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedEventFilter = filter;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: selected ? navy : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: selected
                      ? navy
                      : const Color(0xFFE5E5EC),
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color:
                        selected ? Colors.white : muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumEventCard(
    Map<String, String> activity,
  ) {
    final title = activity['title']!;
    final registered =
        registeredActivities.contains(title);

    final accent = _eventAccent(activity['type']!);

    return GestureDetector(
      onTap: () => registerForActivity(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 13),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: registered
              ? accent.withOpacity(0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: registered
                ? accent.withOpacity(0.28)
                : const Color(0xFFE7E7EF),
            width: registered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.07),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 81,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent,
                    accent.withOpacity(0.65),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activity['date']!
                        .split(' ')[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    activity['date']!
                        .split(' ')[1]
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              accent.withOpacity(0.10),
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: Text(
                          activity['type']!,
                          style: TextStyle(
                            color: accent,
                            fontSize: 8,
                            fontWeight:
                                FontWeight.w900,
                            letterSpacing: 0.9,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (registered)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: mint,
                          size: 18,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activity['time']!,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: muted,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          activity['location']!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _eventAccent(String type) {
    switch (type) {
      case 'CLUB':
        return blue;
      case 'SPORTS':
        return mint;
      case 'CAREER':
        return purple;
      case 'WORKSHOP':
        return pink;
      default:
        return yellow;
    }
  }

  // ============================================================
  // PROFILE
  // ============================================================

  Widget _buildProfilePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 5, 18, 110),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                21,
                22,
                21,
                22,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF24253E),
                    Color(0xFF4F4C96),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: navy.withOpacity(0.18),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -35,
                    top: -40,
                    child: _decorativeCircle(
                      size: 140,
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 85,
                        width: 85,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white24,
                            width: 4,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/cmr_logo.png',
                            fit: BoxFit.contain,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Center(
                                child: Text(
                                  'CMR',
                                  style: TextStyle(
                                    color: navy,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w900,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Pranav R',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Computer Science • INTI',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 19),
                      Row(
                        children: [
                          _profileStat(
                            '${registeredActivities.length}',
                            'Joined',
                          ),
                          const SizedBox(width: 9),
                          _profileStat(
                            '$reminderCount',
                            'Reminders',
                          ),
                          const SizedBox(width: 9),
                          _profileStat(
                            '${interestedDiscoveryItems.length}',
                            'Picks',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _profileInfoTile(
              Icons.badge_rounded,
              'Student ID',
              'CMR2026001',
              blue,
            ),
            _profileInfoTile(
              Icons.school_rounded,
              'Program',
              'Computer Science',
              purple,
            ),
            _profileInfoTile(
              Icons.calendar_month_rounded,
              'Semester',
              'Semester 1',
              mint,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showPremiumSnack(
                  'Profile settings selected.',
                  icon: Icons.settings_rounded,
                );
              },
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE5E5EC),
                  ),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 17),
                    Icon(
                      Icons.settings_rounded,
                      color: navy,
                      size: 21,
                    ),
                    SizedBox(width: 11),
                    Expanded(
                      child: Text(
                        'Profile Settings',
                        style: TextStyle(
                          color: navy,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: muted,
                      size: 15,
                    ),
                    SizedBox(width: 17),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileStat(
    String number,
    String label,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.09),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.10),
          ),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfoTile(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8E8EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.09),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DRAWER
  // ============================================================

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: background,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                22,
                27,
                22,
                24,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    blue,
                    purple,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(17),
                    ),
                    child: Image.asset(
                      'assets/cmr_logo.png',
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'CMR',
                            style: TextStyle(
                              color: navy,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w900,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CMR Campus Connect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'A smarter way to experience campus.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _drawerItem(
              icon: Icons.home_rounded,
              title: 'Home',
              selected: currentIndex == 0,
              onTap: () => changePageFromDrawer(0),
            ),
            _drawerItem(
              icon: Icons.explore_rounded,
              title: 'Discover',
              selected: currentIndex == 1,
              onTap: () => changePageFromDrawer(1),
            ),
            _drawerItem(
              icon: Icons.auto_stories_rounded,
              title: 'Study Hub',
              selected: currentIndex == 2,
              onTap: () => changePageFromDrawer(2),
            ),
            _drawerItem(
              icon: Icons.calendar_month_rounded,
              title: 'Campus Events',
              selected: currentIndex == 3,
              onTap: () => changePageFromDrawer(3),
            ),
            _drawerItem(
              icon: Icons.person_rounded,
              title: 'My Profile',
              selected: currentIndex == 4,
              onTap: () => changePageFromDrawer(4),
            ),
            const Divider(
              height: 30,
              indent: 20,
              endIndent: 20,
            ),
            _drawerItem(
              icon: Icons.flag_rounded,
              title: 'Campus Missions',
              selected: false,
              onTap: () {
                Navigator.pop(context);
                openMissionSheet();
              },
            ),
            _drawerItem(
              icon: Icons.support_agent_rounded,
              title: 'Student Help',
              selected: false,
              onTap: () {
                Navigator.pop(context);

                // Opens the Student Help Request form (Form assignment).
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceRequestFormScreen(),
                  ),
                );
              },
            ),
            _drawerItem(
              icon: Icons.info_outline_rounded,
              title: 'About Campus Connect',
              selected: false,
              onTap: () {
                Navigator.pop(context);

                showAboutDialog(
                  context: context,
                  applicationName: 'CMR Campus Connect',
                  applicationVersion: '2.0.0',
                  applicationLegalese:
                      'Flutter Mini Project - Student Campus Application',
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                'CMR CAMPUS CONNECT • 2026',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 2,
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        tileColor: selected
            ? const Color(0xFFE9EAFF)
            : Colors.transparent,
        leading: Icon(
          icon,
          color: selected ? blue : const Color(0xFF8A8C9A),
          size: 21,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? navy : const Color(0xFF424456),
            fontSize: 13,
            fontWeight:
                selected ? FontWeight.w900 : FontWeight.w700,
          ),
        ),
        trailing: selected
            ? const Icon(
                Icons.arrow_forward_ios_rounded,
                color: blue,
                size: 13,
              )
            : null,
      ),
    );
  }
}