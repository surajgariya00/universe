
import 'package:hive_flutter/hive_flutter.dart';
import '../models/timetable.dart';
class TimetableRepo {
  static Future<List<Slot>> all() async {
    final list = List<Map>.from(Hive.box('timetable').get('items', defaultValue: []));
    return list.map((m)=>Slot.fromMap(Map<String,dynamic>.from(m))).toList();
  }
  static Future<void> save(List<Slot> slots) async {
    final box = Hive.box('timetable');
    await box.put('items', slots.map((s)=>s.toMap()).toList());
  }
}
