import 'package:flutter/material.dart';

// ============================================================
// MODELS + LOCAL SAMPLE DATA (no database or API needed)
// ============================================================

/// Passed to the Service Details route as a route argument.
class CampusService {
  const CampusService({
    required this.name,
    required this.summary,
    required this.description,
    required this.location,
    required this.openingHours,
    required this.contact,
    required this.status,
    required this.icon,
    required this.color,
  });

  final String name;
  final String summary;
  final String description;
  final String location;
  final String openingHours;
  final String contact;
  final String status;
  final IconData icon;
  final Color color;
}

class CampusEvent {
  CampusEvent({
    required this.title,
    required this.day,
    required this.month,
    required this.time,
    required this.venue,
    required this.type,
    required this.description,
    required this.color,
    this.registered = false,
  });

  final String title;
  final String day;
  final String month;
  final String time;
  final String venue;
  final String type;
  final String description;
  final Color color;
  bool registered; // updated when the details route returns a result
}

class ClassEntry {
  const ClassEntry({
    required this.day,
    required this.time,
    required this.module,
    required this.room,
    this.isNext = false,
  });

  final String day;
  final String time;
  final String module;
  final String room;
  final bool isNext;
}

const List<CampusService> campusServices = [
  CampusService(
    name: 'Accommodation Office',
    summary: 'Hostel rooms and housing support',
    description:
        'Handles hostel allocation, room changes, maintenance requests and '
        'general housing enquiries for all residential students.',
    location: 'Hostel Admin Block, Ground Floor',
    openingHours: '8:30 AM - 5:00 PM',
    contact: 'hostel@cmr.edu.in',
    status: 'Open now',
    icon: Icons.home_work_rounded,
    color: Color(0xFF596BFF),
  ),
  CampusService(
    name: 'IT Helpdesk',
    summary: 'Wi-Fi, accounts and lab support',
    description:
        'Help with campus Wi-Fi, student portal logins, email accounts and '
        'software problems in computer labs.',
    location: 'Main Block, Room G-14',
    openingHours: '9:00 AM - 6:00 PM',
    contact: 'ithelp@cmr.edu.in',
    status: 'Open now',
    icon: Icons.computer_rounded,
    color: Color(0xFF9367FF),
  ),
  CampusService(
    name: 'Central Library',
    summary: 'Books, journals and study rooms',
    description:
        'Borrow books, access e-journals, book group study rooms and get '
        'help with research and referencing.',
    location: 'Library Building, Levels 1 to 3',
    openingHours: '8:00 AM - 9:00 PM',
    contact: 'library@cmr.edu.in',
    status: 'Open now',
    icon: Icons.local_library_rounded,
    color: Color(0xFF18A184),
  ),
  CampusService(
    name: 'Counselling & Wellbeing',
    summary: 'Confidential student support',
    description:
        'Private one-to-one sessions and wellbeing workshops for students '
        'who want someone to talk to.',
    location: 'Student Centre, Level 2',
    openingHours: '10:00 AM - 4:30 PM',
    contact: 'wellbeing@cmr.edu.in',
    status: 'By appointment',
    icon: Icons.favorite_rounded,
    color: Color(0xFFFF6692),
  ),
  CampusService(
    name: 'Career & Placement Cell',
    summary: 'Internships, CV help, interviews',
    description:
        'Placement drives, mock interviews, CV reviews and internship '
        'listings for final and pre-final year students.',
    location: 'Admin Block, Level 3',
    openingHours: '9:30 AM - 5:30 PM',
    contact: 'placements@cmr.edu.in',
    status: 'Open now',
    icon: Icons.work_rounded,
    color: Color(0xFFE0A100),
  ),
  CampusService(
    name: 'Transport Desk',
    summary: 'Bus routes and pass renewals',
    description:
        'Bus timetables, route changes and monthly pass renewals for '
        'students who travel to campus.',
    location: 'Main Gate Office',
    openingHours: '7:30 AM - 4:00 PM',
    contact: 'transport@cmr.edu.in',
    status: 'Closed for lunch',
    icon: Icons.directions_bus_rounded,
    color: Color(0xFF3B8BEB),
  ),
];

const List<ClassEntry> timetableEntries = [
  ClassEntry(
    day: 'Mon',
    time: '9:00 - 10:00 AM',
    module: 'Operating Systems',
    room: 'Room B-204',
    isNext: true,
  ),
  ClassEntry(
    day: 'Mon',
    time: '11:00 AM - 1:00 PM',
    module: 'Database Systems Lab',
    room: 'Lab 3',
  ),
  ClassEntry(
    day: 'Tue',
    time: '10:00 - 11:00 AM',
    module: 'Computer Networks',
    room: 'Room C-101',
  ),
  ClassEntry(
    day: 'Wed',
    time: '2:00 - 4:00 PM',
    module: 'Mobile App Development',
    room: 'Lab 5',
  ),
  ClassEntry(
    day: 'Thu',
    time: '9:00 - 10:00 AM',
    module: 'Software Engineering',
    room: 'Room B-110',
  ),
  ClassEntry(
    day: 'Fri',
    time: '1:30 - 2:30 PM',
    module: 'Professional Skills Seminar',
    room: 'Seminar Hall',
  ),
];

/// A fresh list each time so registration state starts clean.
List<CampusEvent> buildSampleEvents() => [
      CampusEvent(
        title: 'Hackathon Kickoff',
        day: '14',
        month: 'OCT',
        time: '10:00 AM',
        venue: 'Innovation Lab',
        type: 'TECH',
        description:
            'A 24-hour build challenge. Form a team, pick a campus problem '
            'and ship a working prototype.',
        color: const Color(0xFF596BFF),
      ),
      CampusEvent(
        title: 'Career Fair 2026',
        day: '18',
        month: 'OCT',
        time: '9:30 AM',
        venue: 'Seminar Hall',
        type: 'CAREER',
        description:
            'Meet recruiters from 30+ companies, drop off your CV and join '
            'short on-the-spot interviews.',
        color: const Color(0xFF9367FF),
      ),
      CampusEvent(
        title: 'Inter-Department Sports Day',
        day: '22',
        month: 'OCT',
        time: '8:00 AM',
        venue: 'Sports Ground',
        type: 'SPORTS',
        description:
            'Cricket, football, relay and more. Cheer for your department '
            'or sign up to play.',
        color: const Color(0xFF18A184),
      ),
      CampusEvent(
        title: 'Cultural Night',
        day: '29',
        month: 'OCT',
        time: '6:00 PM',
        venue: 'Open Air Theatre',
        type: 'CULTURE',
        description:
            'Music, dance and drama performances by student clubs, followed '
            'by food stalls.',
        color: const Color(0xFFFF6692),
      ),
    ];
