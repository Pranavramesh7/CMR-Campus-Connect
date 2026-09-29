import 'package:flutter/material.dart';

void main() {
  runApp(const ContainerApp());
}

class ContainerApp extends StatelessWidget {
  const ContainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMR Container Showcase',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B5D8B),
        ),
      ),
      home: const ContainerHomePage(),
    );
  }
}

class ContainerHomePage extends StatefulWidget {
  const ContainerHomePage({super.key});

  @override
  State<ContainerHomePage> createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage> {
  int selectedCard = 0;

  final List<Map<String, dynamic>> cards = [
    {
      'title': 'Campus Life',
      'subtitle': 'Explore your CMR experience',
      'icon': Icons.school_rounded,
      'color': const Color(0xFF0B5D8B),
    },
    {
      'title': 'Student Activities',
      'subtitle': 'Events, clubs and activities',
      'icon': Icons.groups_rounded,
      'color': const Color(0xFF159BC7),
    },
    {
      'title': 'Learning',
      'subtitle': 'Study smarter at CMR',
      'icon': Icons.menu_book_rounded,
      'color': const Color(0xFF064B73),
    },
  ];

  void showCardMessage(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title selected!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = cards[selectedCard];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0B5D8B),
        foregroundColor: Colors.white,
        title: const Text(
          'CMR Campus Connect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ----------------------------------------------------------
            // HERO SECTION
            // ----------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 34),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0B5D8B),
                    Color(0xFF159BC7),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  // CMR LOGO
                  Container(
                    width: 110,
                    height: 110,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/cmr_logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.school,
                          size: 65,
                          color: Color(0xFF0B5D8B),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'CMR Campus Connect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Everything you need for your campus journey.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ----------------------------------------------------------
            // CONTAINER WIDGET SHOWCASE
            // ----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore CMR',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Main highlighted Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: card['color'] as Color,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: (card['color'] as Color).withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      card['icon'] as IconData,
                      color: Colors.white,
                      size: 55,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      card['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      card['subtitle'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showCardMessage(card['title'] as String);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: card['color'] as Color,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Explore Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ----------------------------------------------------------
            // SMALL CONTAINERS
            // ----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _smallContainer(
                      icon: Icons.event_rounded,
                      title: 'Events',
                      value: '12+',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _smallContainer(
                      icon: Icons.groups_rounded,
                      title: 'Clubs',
                      value: '20+',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _smallContainer(
                      icon: Icons.library_books_rounded,
                      title: 'Library',
                      value: '24/7',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _smallContainer(
                      icon: Icons.location_on_rounded,
                      title: 'Campus',
                      value: 'Explore',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ----------------------------------------------------------
            // SELECTOR
            // ----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose a section',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: List.generate(
                        cards.length,
                        (index) {
                          final isSelected = selectedCard == index;

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCard = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 250),
                                margin: EdgeInsets.only(
                                  right: index == cards.length - 1 ? 0 : 8,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? cards[index]['color'] as Color
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      cards[index]['icon'] as IconData,
                                      color: isSelected
                                          ? Colors.white
                                          : cards[index]['color'] as Color,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      cards[index]['title'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ----------------------------------------------------------
            // FINAL INFORMATION CONTAINER
            // ----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFF0B5D8B).withOpacity(0.12),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F5FB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.lightbulb_rounded,
                        color: Color(0xFF0B5D8B),
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make campus count. 🚀',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Discover, learn, connect and enjoy your CMR journey.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),

      // --------------------------------------------------------------
      // FLOATING ACTION BUTTON
      // --------------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B5D8B),
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Welcome to CMR Campus Connect! 🚀'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Icon(Icons.notifications_active_rounded),
      ),
    );
  }

  // --------------------------------------------------------------
  // SMALL CONTAINER WIDGET
  // --------------------------------------------------------------
  Widget _smallContainer({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5FB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0B5D8B),
              size: 26,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B5D8B),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}