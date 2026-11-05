import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/announcement.dart';

class StorageService {
  static const _itemsKey = 'campus_announcements_v1';
  static const _savedKey = 'campus_saved_ids_v1';

  Future<List<Announcement>> loadAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_itemsKey);
    if (raw == null) return _demoAnnouncements();
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => Announcement.fromJson(
        Map<String, dynamic>.from(e as Map),
      )).toList();
    } catch (_) {
      return _demoAnnouncements();
    }
  }

  Future<Set<String>> loadSavedIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_savedKey) ?? <String>[]).toSet();
  }

  Future<void> save(List<Announcement> items, Set<String> savedIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_itemsKey, jsonEncode(items.map((e) => e.toJson()).toList()));
    await prefs.setStringList(_savedKey, savedIds.toList());
  }

  List<Announcement> _demoAnnouncements() {
    final now = DateTime.now();
    return [
      Announcement(id: 'demo1', title: 'Annual Tech Fest registrations open',
        body: 'Students can register for coding, robotics and project events through the student coordination desk. Check the official college notice board for confirmed dates and rules.',
        category: 'Events', author: 'Student Activity Cell', createdAt: now.subtract(const Duration(hours: 3)), isDemo: true),
      Announcement(id: 'demo2', title: 'Library timing update',
        body: 'A sample notice reminding students to verify the current library schedule with the library office before planning a visit.',
        category: 'Academics', author: 'Library Desk', createdAt: now.subtract(const Duration(days: 1)), isDemo: true),
      Announcement(id: 'demo3', title: 'Placement preparation session',
        body: 'A sample campus update about a placement preparation session covering aptitude practice, resume basics and interview preparation.',
        category: 'Placements', author: 'Career Guidance Cell', createdAt: now.subtract(const Duration(days: 2)), isDemo: true),
      Announcement(id: 'demo4', title: 'Photography club welcomes members',
        body: 'Students interested in photography and visual storytelling can contact the club coordinators for details.',
        category: 'Clubs', author: 'Photography Club', createdAt: now.subtract(const Duration(days: 3)), isDemo: true),
      Announcement(id: 'demo5', title: 'Semester project showcase',
        body: 'A sample announcement inviting project teams to prepare a short demonstration of their semester work.',
        category: 'Events', author: 'Department Desk', createdAt: now.subtract(const Duration(days: 4)), isDemo: true),
    ];
  }
}
