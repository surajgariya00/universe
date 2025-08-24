
import 'package:flutter/material.dart'; import '../models/timetable.dart';
class SlotTile extends StatelessWidget {
  final Slot slot; const SlotTile({super.key, required this.slot});
  @override Widget build(BuildContext context){ return ListTile(leading: const Icon(Icons.schedule_rounded), title: Text(slot.subject), subtitle: Text('${slot.day} • ${slot.start}–${slot.end} • ${slot.room}')); }
}
