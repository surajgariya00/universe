
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';

class SeedService {
  static Future<void> ensureSeed() async {
    await _load('events', 'assets/seed_events.json');
    await _load('clubs', 'assets/seed_clubs.json');
    await _load('posts', 'assets/seed_posts.json');
    await _load('timetable', 'assets/seed_timetable.json');
  }
  static Future<void> _load(String boxName, String asset) async {
    final box = Hive.box(boxName);
    final existing = box.get('items', defaultValue: []);
    if (existing is List && existing.isNotEmpty) return;
    final raw = await rootBundle.loadString(asset);
    final data = json.decode(raw) as List;
    await box.put('items', data);
  }
}
