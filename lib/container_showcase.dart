import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const CMRCampusApp());
}

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
          seedColor: const Color(0xFF596BFF),
          brightness: Brightness.light,
        ),
      ),
      home: const CampusHomePage(),
    );
  }
}

class CampusHomePage extends StatefulWidget {
  const CampusHomePage({super.key});

  @override
  State<CampusHomePage> createState() => _CampusHomePageState();
}

class _CampusHomePageState extends State<CampusHomePage> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color navy = Color(0xFF17182B);
  static const Color blue = Color(0xFF596BFF);
  static const Color purple = Color(0xFF9367FF);
  static const Color pink = Color(0xFFFF6692);
  static const Color mint = Color(0xFF25C9A1);
  static const Color yellow = Color(0xFFFFC85A);
  static const Color background = Color(0xFFF7F7FC);
  static const Color muted = Color(0xFF77798A);

  // ============================================================
  // NAVIGATION
  // ============================================================

  int currentIndex = 0;

  final List<String> pageTitles = [
    'CMR Campus Connect',
    'Discover Campus',
    'Study Hub',
    'Campus Events',
    'My Profile',
  ];

  // ============================================================
  // GENERAL STATE
  // ============================================================

  int reminderCount = 0;
  int points = 120;

  final List<String> registeredActivities = [];

  // ============================================================
  // DISCOVERY STATE
  // ============================================================

  int discoveryIndex = 0;
  bool discoveryAnimating = false;
  Offset discoveryDragOffset = Offset.zero;

  final Set<String> interestedDiscoveryItems = {};

  // ============================================================
  // STUDY STATE
  // ============================================================

  int studyCardIndex = 0;
  bool studyCardRevealed = false;

  Timer? focusTimer;
  int focusSeconds = 20 * 60;
  bool focusRunning = false;

  // ============================================================
  // EVENTS
  // ============================================================

  String selectedEventFilter = 'ALL';

  final List<Map<String, String>> activities = [
    {
      'title': 'Tech Innovation Workshop',
      'date': '24 Sep 2026',
      'time': '10:00 AM',
      'location': 'Innovation Lab',
      'type': 'WORKSHOP',
      'description':
          'Explore new technology ideas, innovation and practical student projects.',
      'image': 'assets/home_page.png',
    },
    {
      'title': 'Coding Club Meetup',
      'date': '26 Sep 2026',
      'time': '2:00 PM',
      'location': 'Computer Lab',
      'type': 'CLUB',
      'description':
          'Meet other students, practise coding and work on exciting ideas together.',
      'image': 'assets/campus_life.jpg',
    },
    {
      'title': 'Campus Sports Day',
      'date': '28 Sep 2026',
      'time': '9:00 AM',
      'location': 'Sports Ground',
      'type': 'SPORTS',
      'description':
          'Take a break from classes and join the campus sports activities.',
      'image': 'assets/campus_life.jpg',
    },
    {
      'title': 'Career Preparation Session',
      'date': '30 Sep 2026',
      'time': '11:30 AM',
      'location': 'Seminar Hall',
      'type': 'CAREER',
      'description':
          'Prepare for internships, interviews and your future career journey.',
      'image': 'assets/home_page.png',
    },
  ];

  // ============================================================
  // DISCOVERY
  // ============================================================

  final List<Map<String, dynamic>> discoveryItems = [
    {
      'title': 'Coding Club',
      'subtitle': 'Build. Break. Learn.',
      'date': 'THIS WEEK',
      'type': 'CLUB',
      'time': '2:00 PM',
      'location': 'Computer Lab',
      'icon': Icons.code_rounded,
      'colors': [blue, purple],
      'description':
          'Meet other students, practise coding and build useful projects together.',
    },
    {
      'title': 'Campus Life',
      'subtitle': 'Create memories together.',
      'date': 'EXPLORE',
      'type': 'CAMPUS',
      'time': 'ALL DAY',
      'location': 'CMR University',
      'icon': Icons.school_rounded,
      'colors': [pink, purple],
      'description':
          'Discover people, places and experiences that make campus life memorable.',
    },
    {
      'title': 'Sports Community',
      'subtitle': 'Move. Compete. Connect.',
      'date': 'CAMPUS LIFE',
      'type': 'SPORTS',
      'time': '9:00 AM',
      'location': 'Sports Ground',
      'icon': Icons.sports_soccer_rounded,
      'colors': [mint, blue],
      'description':
          'Stay active and meet new people through campus sports and activities.',
    },
    {
      'title': 'Career Growth',
      'subtitle': 'Prepare for what comes next.',
      'date': 'CAREER',
      'type': 'CAREER',
      'time': '11:30 AM',
      'location': 'Seminar Hall',
      'icon': Icons.work_outline_rounded,
      'colors': [yellow, pink],
      'description':
          'Build confidence for internships, interviews and your future career journey.',
    },
    {
      'title': 'Innovation Space',
      'subtitle': 'Turn ideas into reality.',
      'date': 'INNOVATE',
      'type': 'TECH',
      'time': '10:00 AM',
      'location': 'Innovation Lab',
      'icon': Icons.lightbulb_outline_rounded,
      'colors': [purple, blue],
      'description':
          'Explore innovation, technology and student ideas that can become real projects.',
    },
  ];

  // ============================================================
  // MISSIONS
  // ============================================================

  final List<Map<String, dynamic>> missions = [
    {
      'title': 'Try something new',
      'description': 'Explore one new campus activity today.',
      'icon': Icons.explore_rounded,
      'color': blue,
    },
    {
      'title': 'Meet your people',
      'description': 'Connect with another student or club.',
      'icon': Icons.groups_rounded,
      'color': pink,
    },
    {
      'title': 'Make time to focus',
      'description': 'Complete one focused study session.',
      'icon': Icons.center_focus_strong_rounded,
      'color': purple,
    },
  ];

  // ============================================================
  // STUDY CARDS
  // ============================================================

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
      'back': 'It tells Flutter that the widget state has changed.',
    },
    {
      'front': 'What is a Scaffold?',
      'back': 'A structure for common Material app screen layouts.',
    },
  ];

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void dispose() {
    focusTimer?.cancel();
    super.dispose();
  }

  // ============================================================
  // NAVIGATION
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
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                size: 18,
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
  // REMINDER
  // ============================================================

  void addReminder() {
    setState(() {
      reminderCount++;
      points += 5;
    });

    showPremiumSnack(
      'Reminder added to your campus plans. +5 points',
      icon: Icons.notifications_active_rounded,
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
      points += 20;
    });

    showPremiumSnack(
      '$title added to your campus plans. +20 points',
      icon: Icons.event_available_rounded,
    );
  }

  // ============================================================
  // DISCOVERY
  // ============================================================

  void nextDiscovery() {
    if (discoveryAnimating) return;

    setState(() {
      discoveryAnimating = true;
      discoveryDragOffset = const Offset(-420, 0);
    });

    Future.delayed(const Duration(milliseconds: 280), () {
      if (!mounted) return;

      setState(() {
        discoveryIndex =
            (discoveryIndex + 1) % discoveryItems.length;
        discoveryDragOffset = Offset.zero;
        discoveryAnimating = false;
      });
    });
  }

  void previousDiscovery() {
    if (discoveryAnimating) return;

    setState(() {
      discoveryAnimating = true;
      discoveryDragOffset = const Offset(420, 0);
    });

    Future.delayed(const Duration(milliseconds: 280), () {
      if (!mounted) return;

      setState(() {
        discoveryIndex =
            (discoveryIndex - 1 + discoveryItems.length) %
                discoveryItems.length;
        discoveryDragOffset = Offset.zero;
        discoveryAnimating = false;
      });
    });
  }

  // ============================================================
  // STUDY
  // ============================================================

  void flipStudyCard() {
    setState(() {
      studyCardRevealed = !studyCardRevealed;
    });
  }

  void nextStudyCard() {
    setState(() {
      studyCardIndex =
          (studyCardIndex + 1) % memoryCards.length;
      studyCardRevealed = false;
    });
  }

  // ============================================================
  // TIMER
  // ============================================================

  void toggleFocusTimer() {
    if (focusRunning) {
      focusTimer?.cancel();

      setState(() {
        focusRunning = false;
      });

      showPremiumSnack(
        'Focus timer paused.',
        icon: Icons.pause_rounded,
      );

      return;
    }

    setState(() {
      focusRunning = true;
    });

    focusTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        if (focusSeconds <= 0) {
          focusTimer?.cancel();

          setState(() {
            focusRunning = false;
            focusSeconds = 20 * 60;
            points += 20;
          });

          showPremiumSnack(
            'Focus session complete! +20 points',
            icon: Icons.emoji_events_rounded,
          );
        } else {
          setState(() {
            focusSeconds--;
          });
        }
      },
    );
  }

  void resetFocusTimer() {
    focusTimer?.cancel();

    setState(() {
      focusRunning = false;
      focusSeconds = 20 * 60;
    });
  }

  String timerText() {
    final minutes =
        (focusSeconds ~/ 60).toString().padLeft(2, '0');

    final seconds =
        (focusSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  // ============================================================
  // LOCAL IMAGE
  // ============================================================

  Widget localImage(
    String path, {
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
  }) {
    return Image.asset(
      path,
      fit: fit,
      alignment: alignment,
      width: double.infinity,
      height: double.infinity,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFE9EBF7),
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported_rounded,
            color: Color(0xFF9A9DAD),
            size: 30,
          ),
        );
      },
    );
  }

  // ============================================================
  // BIG LOGO WIDGET
  //
  // Uses a large image area and a larger inner image so that
  // transparent padding inside the PNG does not make the logo
  // look extremely small.
  // ============================================================

  Widget cmrLogo({
    double size = 180,
    double scale = 1.0,
    String asset = 'assets/cmr_logo.png',
    BorderRadius? radius,
  }) {
    final BorderRadius logoRadius =
        radius ?? BorderRadius.circular(28);

    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: logoRadius,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: logoRadius,
        child: Center(
          child: SizedBox(
            height: size,
            width: size,
            child: Transform.scale(
              scale: scale,
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                width: size,
                height: size,
                filterQuality: FilterQuality.high,
                errorBuilder:
                    (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'CMR',
                      style: TextStyle(
                        color: navy,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP PAGE FRAME
  // ============================================================

  Widget pageFrame({
    required Widget child,
  }) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              32,
              18,
              32,
              125,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // EVENT COLOR
  // ============================================================

  Color eventAccent(String type) {
    switch (type) {
      case 'WORKSHOP':
        return pink;
      case 'CLUB':
        return blue;
      case 'SPORTS':
        return mint;
      case 'CAREER':
        return purple;
      default:
        return yellow;
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 82,

        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 11,
                bottom: 11,
              ),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: navy,
                    size: 23,
                  ),
                ),
              ),
            );
          },
        ),

        titleSpacing: 8,

        title: Row(
          children: [
            cmrLogo(
              size: 68,
              scale: 1.75,
              radius: BorderRadius.circular(17),
            ),
            const SizedBox(width: 13),
            Flexible(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Text(
                    'CMR',
                    style: TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    pageTitles[currentIndex],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: addReminder,
                icon: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: navy,
                    size: 23,
                  ),
                ),
              ),
              if (reminderCount > 0)
                Positioned(
                  right: 1,
                  top: -1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: pink,
                      borderRadius:
                          BorderRadius.circular(10),
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
          const SizedBox(width: 12),
        ],
      ),

      // ========================================================
      // DRAWER
      // ========================================================

      drawer: Drawer(
        backgroundColor: background,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  28,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      navy,
                      Color(0xFF31365C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    cmrLogo(
                      size: 115,
                      scale: 1.75,
                      radius: BorderRadius.circular(25),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'CMR CAMPUS CONNECT',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.7,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Make campus count. 🚀',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              _drawerTile(
                icon: Icons.home_rounded,
                title: 'Home',
                index: 0,
              ),

              _drawerTile(
                icon: Icons.explore_rounded,
                title: 'Discover',
                index: 1,
              ),

              _drawerTile(
                icon: Icons.menu_book_rounded,
                title: 'Study Hub',
                index: 2,
              ),

              _drawerTile(
                icon: Icons.event_rounded,
                title: 'Events',
                index: 3,
              ),

              _drawerTile(
                icon: Icons.person_rounded,
                title: 'Profile',
                index: 4,
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(22),
                  onTap: () {
                    Navigator.pop(context);

                    showAboutDialog(
                      context: context,
                      applicationName:
                          'CMR Campus Connect',
                      applicationVersion: '1.0.0',
                      applicationIcon: cmrLogo(
                        size: 60,
                        scale: 1.6,
                        radius:
                            BorderRadius.circular(16),
                      ),
                      children: const [
                        Text(
                          'A student-focused campus application built with Flutter.',
                        ),
                      ],
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(22),
                      border: Border.all(
                        color:
                            Color(0xFFE9E9F0),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: muted,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'About CMR Campus Connect',
                            style: TextStyle(
                              color: navy,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                        ),
                        Icon(
                          Icons
                              .arrow_forward_ios_rounded,
                          size: 14,
                          color: muted,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

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

      // ========================================================
      // FAB
      // ========================================================

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: addReminder,
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 7,
        icon: const Icon(
          Icons.add_alert_rounded,
        ),
        label: const Text(
          'Reminder',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: changePage,
        backgroundColor: Colors.white,
        elevation: 12,
        indicatorColor: blue.withOpacity(0.12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon:
                Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon:
                Icon(Icons.explore_rounded),
            label: 'Discover',
          ),
          NavigationDestination(
            icon:
                Icon(Icons.menu_book_outlined),
            selectedIcon:
                Icon(Icons.menu_book_rounded),
            label: 'Study',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon:
                Icon(Icons.event_rounded),
            label: 'Events',
          ),
          NavigationDestination(
            icon:
                Icon(Icons.person_outline_rounded),
            selectedIcon:
                Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DRAWER TILE
  // ============================================================

  Widget _drawerTile({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(17),
        ),
        selected: selected,
        selectedTileColor:
            blue.withOpacity(0.10),
        leading: Icon(
          icon,
          color: selected ? blue : muted,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? blue : navy,
            fontWeight: selected
                ? FontWeight.w900
                : FontWeight.w700,
          ),
        ),
        trailing: selected
            ? const Icon(
                Icons.chevron_right_rounded,
                color: blue,
              )
            : null,
        onTap: () =>
            changePageFromDrawer(index),
      ),
    );
  }

  // ============================================================
  // HOME
  // ============================================================

  Widget _buildHomePage() {
    return pageFrame(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _buildGreeting(),
          const SizedBox(height: 24),
          _buildHomeHero(),
          const SizedBox(height: 25),
          _buildStatsRow(),
          const SizedBox(height: 28),
          _buildQuickActions(),
          const SizedBox(height: 28),
          _buildMissionPreview(),
          const SizedBox(height: 28),
          _buildCampusLifeCard(),
          const SizedBox(height: 28),
          _buildUpcomingPreview(),
        ],
      ),
    );
  }

  // ============================================================
  // GREETING
  // ============================================================

  Widget _buildGreeting() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide =
            constraints.maxWidth > 700;

        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hey Pranav',
                          style: TextStyle(
                            color: navy,
                            fontSize: 31,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: ' 👋',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ready to explore campus?',
                    style: TextStyle(
                      color: muted,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            cmrLogo(
              size: wide ? 112 : 92,
              scale: 1.85,
              radius:
                  BorderRadius.circular(26),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // HOME HERO
  // ============================================================

  Widget _buildHomeHero() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width =
            constraints.maxWidth;

        final bool compact = width < 700;

        final double heroHeight =
            compact ? 330 : 365;

        final double logoSize =
            compact ? 155 : 225;

        return Container(
          height: heroHeight,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color:
                    navy.withOpacity(0.16),
                blurRadius: 30,
                offset:
                    const Offset(0, 14),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // REAL LOCAL IMAGE
              localImage(
                'assets/home_page.png',
                fit: BoxFit.cover,
              ),

              Container(
                decoration:
                    const BoxDecoration(
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment.topLeft,
                    end:
                        Alignment.bottomRight,
                    colors: [
                      Color(0x183F51B5),
                      Color(0xEF17182B),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 24,
                child: Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(
                            30),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.18),
                    ),
                  ),
                  child: const Text(
                    'CMR UNIVERSITY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w900,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 30,
                bottom: 30,
                right: compact
                    ? 30
                    : logoSize + 65,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Text(
                      'MAKE CAMPUS COUNT. 🚀',
                      style: TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      compact
                          ? 'Discover your\ncampus life.'
                          : 'Discover your\ncampus life.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            compact ? 31 : 37,
                        fontWeight:
                            FontWeight.w900,
                        height: 1.02,
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      'Events, clubs, study tools and student life in one place.',
                      style: TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 13,
                        height: 1.45,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () =>
                          changePage(3),
                      icon: const Icon(
                        Icons.event_rounded,
                        size: 17,
                      ),
                      label: const Text(
                        'EXPLORE EVENTS',
                      ),
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            Colors.white,
                        foregroundColor:
                            navy,
                        elevation: 0,
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            15,
                          ),
                        ),
                        textStyle:
                            const TextStyle(
                          fontSize: 10,
                          fontWeight:
                              FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // BIG LOCAL CMR LOGO
              Positioned(
                top: compact ? 92 : 62,
                right: compact ? 20 : 42,
                child: cmrLogo(
                  size: logoSize,
                  scale: 2.0,
                  radius:
                      BorderRadius.circular(
                    compact ? 28 : 36,
                  ),
                ),
              ),

              Positioned(
                right: compact ? 20 : 62,
                bottom: compact ? 18 : 28,
                child: Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.12),
                    borderRadius:
                        BorderRadius.circular(
                            30),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.15),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'YOUR CAMPUS • YOUR STORY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // STATS
  // ============================================================

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            value: '${activities.length}',
            label: 'Events',
            icon:
                Icons.event_available_rounded,
            color: blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            value:
                '${registeredActivities.length}',
            label: 'Registered',
            icon:
                Icons.bookmark_added_rounded,
            color: pink,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            value: '$points',
            label: 'Points',
            icon: Icons.stars_rounded,
            color: mint,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE9E9F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color:
                  color.withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: navy,
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: muted,
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QUICK ACCESS
  // ============================================================

  Widget _buildQuickActions() {
    final actions = [
      {
        'title': 'Library',
        'subtitle': 'Study space',
        'icon': Icons.local_library_rounded,
        'color': blue,
      },
      {
        'title': 'Campus Map',
        'subtitle': 'Find your way',
        'icon': Icons.map_rounded,
        'color': purple,
      },
      {
        'title': 'Clubs',
        'subtitle': 'Meet people',
        'icon': Icons.groups_rounded,
        'color': pink,
      },
      {
        'title': 'Student Help',
        'subtitle': 'Need support?',
        'icon': Icons.support_agent_rounded,
        'color': mint,
      },
    ];

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'QUICK ACCESS',
          style: TextStyle(
            color: muted,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3.4,
          ),
          itemBuilder:
              (context, index) {
            final item = actions[index];
            final Color color =
                item['color'] as Color;

            return GestureDetector(
              onTap: () {
                showPremiumSnack(
                  '${item['title']} opened.',
                  icon:
                      item['icon'] as IconData,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.all(
                  17,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    22,
                  ),
                  border: Border.all(
                    color: const Color(
                        0xFFE9E9F0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 47,
                      width: 47,
                      decoration:
                          BoxDecoration(
                        gradient:
                            LinearGradient(
                          colors: [
                            color,
                            color.withOpacity(
                                0.68),
                          ],
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          15,
                        ),
                      ),
                      child: Icon(
                        item['icon']
                            as IconData,
                        color:
                            Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(
                        width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            item['title']
                                as String,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              color: navy,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight
                                      .w900,
                            ),
                          ),
                          const SizedBox(
                              height: 3),
                          Text(
                            item['subtitle']
                                as String,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              color: muted,
                              fontSize: 10,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // MISSION
  // ============================================================

  Widget _buildMissionPreview() {
    final mission = missions[0];

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          shape:
              const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  22,
                  16,
                  22,
                  25,
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Container(
                      height: 5,
                      width: 45,
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFFDADAE4,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment:
                          Alignment.centerLeft,
                      child: Text(
                        'TODAY’S MISSIONS',
                        style:
                            TextStyle(
                          color: muted,
                          fontSize: 10,
                          fontWeight:
                              FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment:
                          Alignment.centerLeft,
                      child: Text(
                        'Make campus count.',
                        style:
                            TextStyle(
                          color: navy,
                          fontSize: 27,
                          fontWeight:
                              FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...missions.map(
                      (m) => Padding(
                        padding:
                            const EdgeInsets
                                .only(
                          bottom: 10,
                        ),
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .all(14),
                          decoration:
                              BoxDecoration(
                            color:
                                background,
                            borderRadius:
                                BorderRadius
                                    .circular(
                              20,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 44,
                                width: 44,
                                decoration:
                                    BoxDecoration(
                                  gradient:
                                      LinearGradient(
                                    colors: [
                                      m['color']
                                          as Color,
                                      (m['color']
                                              as Color)
                                          .withOpacity(
                                        0.65,
                                      ),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    14,
                                  ),
                                ),
                                child:
                                    Icon(
                                  m['icon']
                                      as IconData,
                                  color:
                                      Colors
                                          .white,
                                  size: 21,
                                ),
                              ),
                              const SizedBox(
                                  width: 12),
                              Expanded(
                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      m['title']
                                          as String,
                                      style:
                                          const TextStyle(
                                        color:
                                            navy,
                                        fontWeight:
                                            FontWeight
                                                .w900,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 3),
                                    Text(
                                      m['description']
                                          as String,
                                      style:
                                          const TextStyle(
                                        color:
                                            muted,
                                        fontSize:
                                            11,
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '+20',
                                style:
                                    TextStyle(
                                  color:
                                      m['color']
                                          as Color,
                                  fontWeight:
                                      FontWeight
                                          .w900,
                                  fontSize:
                                      13,
                                ),
                              ),
                            ],
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
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              blue.withOpacity(0.06),
            ],
          ),
          borderRadius:
              BorderRadius.circular(23),
          border: Border.all(
            color: blue.withOpacity(0.13),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration:
                  BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    blue,
                    purple,
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.flag_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TODAY’S MISSION',
                    style: TextStyle(
                      color: muted,
                      fontSize: 9,
                      fontWeight:
                          FontWeight.w900,
                      letterSpacing: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mission['title']
                        as String,
                    style:
                        const TextStyle(
                      color: navy,
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mission['description']
                        as String,
                    style:
                        const TextStyle(
                      color: muted,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: navy,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CAMPUS LIFE
  // ============================================================

  Widget _buildCampusLifeCard() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'CAMPUS LIFE',
          style: TextStyle(
            color: muted,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 285,
          width: double.infinity,
          clipBehavior:
              Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:
                    navy.withOpacity(0.12),
                blurRadius: 22,
                offset:
                    const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // REAL LOCAL IMAGE
              localImage(
                'assets/campus_life.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                decoration:
                    const BoxDecoration(
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment.topCenter,
                    end:
                        Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xF517182B),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 24,
                right: 24,
                bottom: 25,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LIVE YOUR CAMPUS STORY',
                      style:
                          TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 9,
                        fontWeight:
                            FontWeight.w900,
                        letterSpacing: 1.3,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'More than classrooms.',
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                        fontSize: 29,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Discover people, places and experiences.',
                      style:
                          TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // UPCOMING
  // ============================================================

  Widget _buildUpcomingPreview() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'UP NEXT',
                style: TextStyle(
                  color: muted,
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w900,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  changePage(3),
              child: const Text(
                'See all',
                style: TextStyle(
                  color: blue,
                  fontSize: 11,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ...activities
            .take(2)
            .map(_buildCompactEvent),
      ],
    );
  }

  Widget _buildCompactEvent(
    Map<String, String> activity,
  ) {
    final String type =
        activity['type']!;
    final Color accent =
        eventAccent(type);

    return GestureDetector(
      onTap: () =>
          registerForActivity(
        activity['title']!,
      ),
      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),
        padding:
            const EdgeInsets.all(13),
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(21),
          border: Border.all(
            color:
                const Color(0xFFE9E9F0),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 76,
              width: 86,
              clipBehavior:
                  Clip.antiAlias,
              decoration:
                  BoxDecoration(
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  localImage(
                    activity['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(
                      gradient:
                          LinearGradient(
                        begin:
                            Alignment.topCenter,
                        end:
                            Alignment.bottomCenter,
                        colors: [
                          accent.withOpacity(
                              0.15),
                          accent.withOpacity(
                              0.80),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      activity['date']!
                          .split(' ')[0],
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w900,
                      ),
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
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration:
                        BoxDecoration(
                      color: accent
                          .withOpacity(0.10),
                      borderRadius:
                          BorderRadius
                              .circular(30),
                    ),
                    child: Text(
                      type,
                      style:
                          TextStyle(
                        color: accent,
                        fontSize: 8,
                        fontWeight:
                            FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    activity['title']!,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      color: navy,
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${activity['time']} • ${activity['location']}',
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      color: muted,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: muted,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DISCOVER
  // ============================================================

  Widget _buildDiscoverPage() {
    final Map<String, dynamic> item =
        discoveryItems[discoveryIndex];

    final List<Color> colors =
        (item['colors'] as List)
            .cast<Color>();

    return pageFrame(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'SWIPE. SAVE. EXPLORE.',
            style: TextStyle(
              color: blue,
              fontSize: 10,
              fontWeight:
                  FontWeight.w900,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Discover campus.',
            style: TextStyle(
              color: navy,
              fontSize: 31,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Find something interesting and make it part of your week.',
            style: TextStyle(
              color: muted,
              fontSize: 12,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onHorizontalDragUpdate:
                (details) {
              setState(() {
                discoveryDragOffset +=
                    Offset(
                  details.delta.dx,
                  0,
                );
              });
            },
            onHorizontalDragEnd:
                (details) {
              if (discoveryDragOffset.dx >
                  110) {
                setState(() {
                  discoveryDragOffset =
                      const Offset(
                    420,
                    0,
                  );
                });

                Future.delayed(
                  const Duration(
                    milliseconds: 220,
                  ),
                  previousDiscovery,
                );
              } else if (discoveryDragOffset
                      .dx <
                  -110) {
                setState(() {
                  discoveryDragOffset =
                      const Offset(
                    -420,
                    0,
                  );
                });

                Future.delayed(
                  const Duration(
                    milliseconds: 220,
                  ),
                  nextDiscovery,
                );
              } else {
                setState(() {
                  discoveryDragOffset =
                      Offset.zero;
                });
              }
            },
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor:
                        Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        26,
                      ),
                    ),
                    title: Text(
                      item['title']
                          as String,
                      style:
                          const TextStyle(
                        color: navy,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                    content: Text(
                      item['description']
                          as String,
                      style:
                          const TextStyle(
                        color: muted,
                        height: 1.5,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                          context,
                        ),
                        child:
                            const Text(
                          'Close',
                          style:
                              TextStyle(
                            color: blue,
                            fontWeight:
                                FontWeight
                                    .w900,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );

                          setState(() {
                            interestedDiscoveryItems
                                .add(
                              item['title']
                                  as String,
                            );
                            points += 10;
                          });

                          showPremiumSnack(
                            'Saved to your interests. +10 points',
                            icon: Icons
                                .favorite_rounded,
                          );
                        },
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              navy,
                          foregroundColor:
                              Colors.white,
                        ),
                        child:
                            const Text(
                          'SAVE',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 260,
              ),
              curve:
                  Curves.easeOutBack,
              transform:
                  Matrix4.identity()
                    ..translate(
                      discoveryDragOffset
                          .dx,
                      discoveryDragOffset
                              .dy *
                          0.15,
                    )
                    ..rotateZ(
                      discoveryDragOffset
                              .dx *
                          0.0009,
                    ),
              height: 455,
              width: double.infinity,
              clipBehavior:
                  Clip.antiAlias,
              decoration:
                  BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  34,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors
                        .first
                        .withOpacity(
                      0.30,
                    ),
                    blurRadius: 30,
                    offset:
                        const Offset(
                      0,
                      16,
                    ),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // LOCAL CAMPUS IMAGE
                  localImage(
                    'assets/campus_life.jpg',
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration:
                        BoxDecoration(
                      gradient:
                          LinearGradient(
                        colors: [
                          colors.first
                              .withOpacity(
                            0.72,
                          ),
                          colors.last
                              .withOpacity(
                            0.92,
                          ),
                        ],
                        begin:
                            Alignment
                                .topLeft,
                        end: Alignment
                            .bottomRight,
                      ),
                    ),
                  ),

                  Container(
                    decoration:
                        BoxDecoration(
                      gradient:
                          LinearGradient(
                        begin:
                            Alignment.topCenter,
                        end:
                            Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          colors.last
                              .withOpacity(
                            0.70,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 22,
                    right: 22,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(
                          0.17,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          30,
                        ),
                        border:
                            Border.all(
                          color: Colors
                              .white
                              .withOpacity(
                            0.15,
                          ),
                        ),
                      ),
                      child: Text(
                        item['type']
                            as String,
                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight
                                  .w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets
                            .all(28),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .white
                                .withOpacity(
                              0.16,
                            ),
                            borderRadius:
                                BorderRadius
                                    .circular(
                              19,
                            ),
                            border:
                                Border.all(
                              color: Colors
                                  .white
                                  .withOpacity(
                                0.17,
                              ),
                            ),
                          ),
                          child: Icon(
                            item['icon']
                                as IconData,
                            color:
                                Colors.white,
                            size: 29,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          item['date']
                              as String,
                          style:
                              const TextStyle(
                            color: Colors
                                .white70,
                            fontSize: 11,
                            fontWeight:
                                FontWeight
                                    .w900,
                            letterSpacing:
                                1.4,
                          ),
                        ),

                        const SizedBox(
                            height: 8),

                        Text(
                          item['title']
                              as String,
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 32,
                            fontWeight:
                                FontWeight
                                    .w900,
                            height: 1.04,
                          ),
                        ),

                        const SizedBox(
                            height: 8),

                        Text(
                          item['subtitle']
                              as String,
                          style:
                              const TextStyle(
                            color: Colors
                                .white70,
                            fontSize: 13,
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),

                        const SizedBox(
                            height: 18),

                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .access_time_rounded,
                              color:
                                  Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                                width: 6),
                            Text(
                              item['time']
                                  as String,
                              style:
                                  const TextStyle(
                                color: Colors
                                    .white,
                                fontSize: 11,
                                fontWeight:
                                    FontWeight
                                        .w800,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .location_on_rounded,
                              color:
                                  Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                                width: 6),
                            Expanded(
                              child: Text(
                                item['location']
                                    as String,
                                maxLines: 1,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white,
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight
                                          .w800,
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
          ),

          const SizedBox(height: 17),

          Row(
            children: [
              Expanded(
                child:
                    OutlinedButton.icon(
                  onPressed:
                      previousDiscovery,
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                  label: const Text(
                    'PASS',
                  ),
                  style:
                      OutlinedButton
                          .styleFrom(
                    foregroundColor:
                        pink,
                    side: BorderSide(
                      color:
                          pink.withOpacity(
                        0.25,
                      ),
                    ),
                    minimumSize:
                        const Size
                            .fromHeight(
                      50,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        17,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child:
                    ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      interestedDiscoveryItems
                          .add(
                        item['title']
                            as String,
                      );
                      points += 10;
                    });

                    showPremiumSnack(
                      'Saved to your interests. +10 points',
                      icon: Icons
                          .favorite_rounded,
                    );

                    nextDiscovery();
                  },
                  icon: const Icon(
                    Icons.favorite_rounded,
                  ),
                  label: const Text(
                    'INTERESTED',
                  ),
                  style:
                      ElevatedButton
                          .styleFrom(
                    backgroundColor:
                        mint,
                    foregroundColor:
                        Colors.white,
                    minimumSize:
                        const Size
                            .fromHeight(
                      50,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'YOUR INTERESTS',
                  style: TextStyle(
                    color: muted,
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Text(
                '${interestedDiscoveryItems.length} saved',
                style: const TextStyle(
                  color: blue,
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (interestedDiscoveryItems
              .isEmpty)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                20,
              ),
              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  21,
                ),
                border: Border.all(
                  color: const Color(
                      0xFFE9E9F0),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons
                        .favorite_border_rounded,
                    color: muted,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Swipe through activities and save the ones you like.',
                      style:
                          TextStyle(
                        color: muted,
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            ...interestedDiscoveryItems
                .map(
              (saved) => Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 9,
                ),
                padding:
                    const EdgeInsets.all(
                  14,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius
                          .circular(18),
                  border: Border.all(
                    color: const Color(
                        0xFFE9E9F0),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons
                          .favorite_rounded,
                      color: pink,
                      size: 18,
                    ),
                    const SizedBox(
                        width: 10),
                    Expanded(
                      child: Text(
                        saved,
                        style:
                            const TextStyle(
                          color: navy,
                          fontWeight:
                              FontWeight
                                  .w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // STUDY
  // ============================================================

  Widget _buildStudyPage() {
    final card =
        memoryCards[studyCardIndex];

    return pageFrame(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'STUDY SMARTER',
            style: TextStyle(
              color: purple,
              fontSize: 10,
              fontWeight:
                  FontWeight.w900,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your study space.',
            style: TextStyle(
              color: navy,
              fontSize: 31,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Recall, focus and keep moving.',
            style: TextStyle(
              color: muted,
              fontSize: 12,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),

          GestureDetector(
            onTap: flipStudyCard,
            child: AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 350,
              ),
              height: 255,
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                28,
              ),
              decoration:
                  BoxDecoration(
                gradient:
                    LinearGradient(
                  colors:
                      studyCardRevealed
                          ? [
                              mint,
                              const Color(
                                  0xFF0C9274),
                            ]
                          : [
                              purple,
                              blue,
                            ],
                  begin:
                      Alignment.topLeft,
                  end: Alignment
                      .bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
                boxShadow: [
                  BoxShadow(
                    color: purple
                        .withOpacity(
                            0.25),
                    blurRadius: 24,
                    offset:
                        const Offset(
                      0,
                      12,
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    studyCardRevealed
                        ? 'ANSWER'
                        : 'FLASH CARD',
                    style:
                        const TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w900,
                      letterSpacing: 1.7,
                    ),
                  ),
                  const SizedBox(
                      height: 12),
                  Text(
                    studyCardRevealed
                        ? card['back']!
                        : card['front']!,
                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight:
                          FontWeight.w900,
                      height: 1.12,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons
                            .touch_app_rounded,
                        color:
                            Colors.white70,
                        size: 17,
                      ),
                      const SizedBox(
                          width: 7),
                      Text(
                        studyCardRevealed
                            ? 'Tap to see question'
                            : 'Tap to reveal answer',
                        style:
                            const TextStyle(
                          color:
                              Colors.white70,
                          fontSize: 10,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed:
                  nextStudyCard,
              style:
                  OutlinedButton.styleFrom(
                minimumSize:
                    const Size.fromHeight(
                  49,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    16,
                  ),
                ),
              ),
              child: const Text(
                'NEXT CARD',
                style: TextStyle(
                  color: navy,
                  fontWeight:
                      FontWeight.w900,
                  fontSize: 10,
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'FOCUS TIMER',
            style: TextStyle(
              color: muted,
              fontSize: 10,
              fontWeight:
                  FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(
              20,
            ),
            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                25,
              ),
              border: Border.all(
                color: const Color(
                  0xFFE9E9F0,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 165,
                  width: 165,
                  decoration:
                      BoxDecoration(
                    shape:
                        BoxShape.circle,
                    gradient:
                        const LinearGradient(
                      colors: [
                        navy,
                        purple,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: purple
                            .withOpacity(
                          0.22,
                        ),
                        blurRadius: 22,
                        offset:
                            const Offset(
                          0,
                          10,
                        ),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      timerText(),
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 35,
                        fontWeight:
                            FontWeight
                                .w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 18),
                Row(
                  children: [
                    Expanded(
                      child:
                          ElevatedButton
                              .icon(
                        onPressed:
                            toggleFocusTimer,
                        icon: Icon(
                          focusRunning
                              ? Icons
                                  .pause_rounded
                              : Icons
                                  .play_arrow_rounded,
                        ),
                        label: Text(
                          focusRunning
                              ? 'PAUSE'
                              : 'START',
                        ),
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              navy,
                          foregroundColor:
                              Colors
                                  .white,
                          minimumSize:
                              const Size
                                  .fromHeight(
                            48,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10),
                    IconButton(
                      onPressed:
                          resetFocusTimer,
                      icon:
                          const Icon(
                        Icons
                            .refresh_rounded,
                        color: muted,
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

  // ============================================================
  // EVENTS
  // ============================================================

  Widget _buildEventsPage() {
    final filtered =
        selectedEventFilter == 'ALL'
            ? activities
            : activities
                .where(
                  (event) =>
                      event['type'] ==
                      selectedEventFilter,
                )
                .toList();

    final filters = [
      'ALL',
      'WORKSHOP',
      'CLUB',
      'SPORTS',
      'CAREER',
    ];

    return pageFrame(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'WHAT’S HAPPENING',
            style: TextStyle(
              color: pink,
              fontSize: 10,
              fontWeight:
                  FontWeight.w900,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Campus events.',
            style: TextStyle(
              color: navy,
              fontSize: 31,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Register for activities and earn points.',
            style: TextStyle(
              color: muted,
              fontSize: 12,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),

          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection:
                  Axis.horizontal,
              itemCount:
                  filters.length,
              separatorBuilder:
                  (_, __) =>
                      const SizedBox(
                width: 8,
              ),
              itemBuilder:
                  (context, index) {
                final filter =
                    filters[index];

                final bool selected =
                    selectedEventFilter ==
                        filter;

                return ChoiceChip(
                  label:
                      Text(filter),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      selectedEventFilter =
                          filter;
                    });
                  },
                  labelStyle:
                      TextStyle(
                    color: selected
                        ? Colors.white
                        : navy,
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w900,
                  ),
                  selectedColor:
                      navy,
                  backgroundColor:
                      Colors.white,
                  side: BorderSide(
                    color: selected
                        ? navy
                        : const Color(
                            0xFFE9E9F0,
                          ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder:
                (context, constraints) {
              final bool twoColumns =
                  constraints.maxWidth >=
                      900;

              final double cardWidth =
                  twoColumns
                      ? (constraints
                                  .maxWidth -
                              16) /
                          2
                      : constraints
                          .maxWidth;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: filtered
                    .map(
                      (event) => SizedBox(
                        width: cardWidth,
                        child:
                            _eventLargeCard(
                          event,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LARGE EVENT CARD
  // ============================================================

  Widget _eventLargeCard(
    Map<String, String> event,
  ) {
    final Color accent =
        eventAccent(event['type']!);

    final bool registered =
        registeredActivities.contains(
      event['title'],
    );

    return Container(
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(25),
        border: Border.all(
          color:
              const Color(0xFFE9E9F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.03),
            blurRadius: 15,
            offset:
                const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius
                    .vertical(
              top: Radius.circular(25),
            ),
            child: SizedBox(
              height: 205,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  localImage(
                    event['image']!,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration:
                        BoxDecoration(
                      gradient:
                          LinearGradient(
                        begin: Alignment
                            .topCenter,
                        end: Alignment
                            .bottomCenter,
                        colors: [
                          Colors.transparent,
                          navy.withOpacity(
                            0.82,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(
                          0.92,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          30,
                        ),
                      ),
                      child: Text(
                        event['type']!,
                        style:
                            TextStyle(
                          color: accent,
                          fontSize: 8,
                          fontWeight:
                              FontWeight
                                  .w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 17,
                    right: 17,
                    bottom: 16,
                    child: Text(
                      event['title']!,
                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight
                                .w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.all(
              17,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child:
                          _eventDetail(
                        Icons
                            .calendar_today_rounded,
                        event['date']!,
                      ),
                    ),
                    Expanded(
                      child:
                          _eventDetail(
                        Icons
                            .access_time_rounded,
                        event['time']!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                _eventDetail(
                  Icons
                      .location_on_rounded,
                  event['location']!,
                ),
                const SizedBox(
                    height: 9),
                Align(
                  alignment:
                      Alignment.centerLeft,
                  child: Text(
                    event['description']!,
                    maxLines: 2,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      color: muted,
                      fontSize: 10,
                      height: 1.4,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 14),
                SizedBox(
                  width:
                      double.infinity,
                  height: 49,
                  child:
                      ElevatedButton(
                    onPressed: registered
                        ? null
                        : () =>
                            registerForActivity(
                              event[
                                  'title']!,
                            ),
                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          registered
                              ? Colors.grey
                                  .shade300
                              : navy,
                      foregroundColor:
                          registered
                              ? muted
                              : Colors
                                  .white,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          16,
                        ),
                      ),
                    ),
                    child: Text(
                      registered
                          ? 'REGISTERED ✓'
                          : 'REGISTER NOW',
                      style:
                          const TextStyle(
                        fontSize: 10,
                        fontWeight:
                            FontWeight
                                .w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventDetail(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: blue,
          size: 15,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style:
                const TextStyle(
              color: navy,
              fontSize: 10,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROFILE
  // ============================================================

  Widget _buildProfilePage() {
    final double completion =
        registeredActivities.length /
            activities.length;

    return pageFrame(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(30),
            decoration:
                BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  navy,
                  Color(0xFF303862),
                ],
                begin:
                    Alignment.topLeft,
                end:
                    Alignment.bottomRight,
              ),
              borderRadius:
                  BorderRadius.circular(
                30,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      navy.withOpacity(
                    0.20,
                  ),
                  blurRadius: 25,
                  offset:
                      const Offset(0, 11),
                ),
              ],
            ),
            child: Column(
              children: [
                cmrLogo(
                  size: 190,
                  scale: 1.75,
                  asset:
                      'assets/cmr_logo2.png',
                  radius:
                      BorderRadius.circular(
                    38,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'PRANAV',
                  style:
                      TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight:
                        FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Computer Science Student',
                  style:
                      TextStyle(
                    color:
                        Colors.white70,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
                const SizedBox(
                    height: 20),
                Row(
                  children: [
                    Expanded(
                      child:
                          _profileStat(
                        '$points',
                        'Points',
                      ),
                    ),
                    Expanded(
                      child:
                          _profileStat(
                        '${registeredActivities.length}',
                        'Registered',
                      ),
                    ),
                    Expanded(
                      child:
                          _profileStat(
                        '${interestedDiscoveryItems.length}',
                        'Saved',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _profileProgressCard(
            completion,
          ),

          const SizedBox(height: 15),

          _profileMenu(
            Icons
                .notifications_active_rounded,
            'Reminders',
            '$reminderCount active',
            blue,
            addReminder,
          ),

          _profileMenu(
            Icons.stars_rounded,
            'Campus points',
            '$points points earned',
            yellow,
            () {
              showPremiumSnack(
                'Keep exploring to earn more points.',
                icon:
                    Icons.stars_rounded,
              );
            },
          ),

          _profileMenu(
            Icons.info_outline_rounded,
            'Student information',
            'CMR Campus Connect profile',
            purple,
            () {
              showPremiumSnack(
                'Profile information ready.',
                icon:
                    Icons.person_rounded,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _profileStat(
    String value,
    String label,
  ) {
    return Column(
      children: [
        Text(
          value,
          style:
              const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight:
                FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style:
              const TextStyle(
            color: Colors.white70,
            fontSize: 9,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _profileProgressCard(
    double completion,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(19),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          23,
        ),
        border: Border.all(
          color:
              const Color(0xFFE9E9F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'CAMPUS PARTICIPATION',
            style: TextStyle(
              color: muted,
              fontSize: 9,
              fontWeight:
                  FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'You are building your campus story.',
            style:
                TextStyle(
              color: navy,
              fontSize: 15,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(
              height: 14),
          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
            child:
                LinearProgressIndicator(
              value: completion,
              minHeight: 10,
              backgroundColor:
                  const Color(
                0xFFEDEDF4,
              ),
              valueColor:
                  const AlwaysStoppedAnimation<
                      Color>(
                blue,
              ),
            ),
          ),
          const SizedBox(
              height: 8),
          Text(
            '${(completion * 100).round()}% event participation',
            style:
                const TextStyle(
              color: muted,
              fontSize: 10,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileMenu(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          20,
        ),
        border: Border.all(
          color:
              const Color(0xFFE9E9F0),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets
                .symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        leading: Container(
          height: 42,
          width: 42,
          decoration:
              BoxDecoration(
            color: color.withOpacity(
              0.10,
            ),
            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style:
              const TextStyle(
            color: navy,
            fontSize: 13,
            fontWeight:
                FontWeight.w900,
          ),
        ),
        subtitle: Text(
          subtitle,
          style:
              const TextStyle(
            color: muted,
            fontSize: 10,
            fontWeight:
                FontWeight.w600,
          ),
        ),
        trailing:
            const Icon(
          Icons
              .arrow_forward_ios_rounded,
          color: muted,
          size: 14,
        ),
      ),
    );
  }
}