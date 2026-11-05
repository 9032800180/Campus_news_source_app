import 'package:flutter/foundation.dart';
import '../models/announcement.dart';
import '../services/storage_service.dart';

class CampusProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();
  List<Announcement> _items = [];
  Set<String> _savedIds = {};
  bool isLoading = false;
  String? error;

  List<Announcement> get items => List.unmodifiable(_items);
  Set<String> get savedIds => Set.unmodifiable(_savedIds);
  List<Announcement> get savedItems =>
      _items.where((item) => _savedIds.contains(item.id)).toList();

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      _items = await _storage.loadAnnouncements();
      _savedIds = await _storage.loadSavedIds();
    } catch (_) {
      error = 'Could not load campus updates. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Announcement> filtered(String query, String category) {
    return _items.where((item) {
      final matchesCategory = category == 'All' || item.category == category;
      final q = query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          item.title.toLowerCase().contains(q) ||
          item.body.toLowerCase().contains(q) ||
          item.author.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Future<void> addAnnouncement({
    required String title,
    required String body,
    required String category,
    required String author,
  }) async {
    final item = Announcement(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      body: body.trim(),
      category: category,
      author: author.trim(),
      createdAt: DateTime.now(),
    );
    _items = [item, ..._items];
    await _persist();
    notifyListeners();
  }

  Future<void> toggleSaved(String id) async {
    if (_savedIds.contains(id)) {
      _savedIds.remove(id);
    } else {
      _savedIds.add(id);
    }
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() => _storage.save(_items, _savedIds);
}
