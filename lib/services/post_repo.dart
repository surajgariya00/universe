
import 'package:hive_flutter/hive_flutter.dart';
import '../models/post.dart';
class PostRepo {
  static Future<List<Post>> all() async {
    final list = List<Map>.from(Hive.box('posts').get('items', defaultValue: []));
    final campus = Hive.box('settings').get('campusId', defaultValue: 'UNI-DEMO');
    return list.where((m) => (m['campusId'] ?? 'UNI-DEMO') == campus).map((m)=>Post.fromMap(Map<String,dynamic>.from(m))).toList();
  }
  static Future<void> add(Post p) async {
    final box = Hive.box('posts');
    final current = List<Map<String,dynamic>>.from(box.get('items', defaultValue: []));
    current.add(p.toMap()); await box.put('items', current);
  }
}
