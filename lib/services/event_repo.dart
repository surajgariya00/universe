
import 'package:hive_flutter/hive_flutter.dart';
import '../models/event.dart';
class EventRepo {
  static Future<List<Event>> all() async {
    final list = List<Map>.from(Hive.box('events').get('items', defaultValue: []));
    final campus = Hive.box('settings').get('campusId', defaultValue: 'UNI-DEMO');
    return list.where((m) => (m['campusId'] ?? 'UNI-DEMO') == campus).map((m)=>Event.fromMap(Map<String,dynamic>.from(m))).toList();
  }
}
