
import 'package:hive_flutter/hive_flutter.dart';
import '../models/club.dart';
class ClubRepo {
  static Future<List<Club>> all() async {
    final list = List<Map>.from(Hive.box('clubs').get('items', defaultValue: []));
    final campus = Hive.box('settings').get('campusId', defaultValue: 'UNI-DEMO');
    return list.where((m) => (m['campusId'] ?? 'UNI-DEMO') == campus).map((m)=>Club.fromMap(Map<String,dynamic>.from(m))).toList();
  }
}
