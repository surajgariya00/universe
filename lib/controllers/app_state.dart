
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppState extends ChangeNotifier {
  bool dark = false;
  int seed = 0;
  AppState() {
    final box = Hive.box('settings');
    dark = box.get('dark', defaultValue: false);
    seed = box.get('seed', defaultValue: 0);
  }
  void toggleDark() { dark = !dark; Hive.box('settings').put('dark', dark); notifyListeners(); }
  void setSeed(int i) { seed = i; Hive.box('settings').put('seed', i); notifyListeners(); }
}
