
import 'package:flutter/material.dart'; import 'package:collection/collection.dart';
import '../services/timetable_repo.dart'; import '../models/timetable.dart'; import '../widgets/slot_tile.dart';
class SchedulePage extends StatefulWidget { const SchedulePage({super.key}); @override State<SchedulePage> createState()=>_SchedulePageState(); }
class _SchedulePageState extends State<SchedulePage> {
  List<Slot> _slots=[]; bool _loading=true;
  @override void initState(){ super.initState(); _load(); }
  Future<void> _load() async { setState(()=>_loading=true); final slots=await TimetableRepo.all(); setState((){ _slots=slots; _loading=false; }); }
  @override Widget build(BuildContext context){
    final byDay = groupBy(_slots, (Slot s)=>s.day); final days=['Mon','Tue','Wed','Thu','Fri','Sat'];
    return SafeArea(child: _loading? const Center(child:CircularProgressIndicator()) : ListView(children: days.map((d){ final list=(byDay[d]??[]).toList(); return ExpansionTile(title: Text(d), children: list.map((s)=> SlotTile(slot:s)).toList()); }).toList()));
  }
}
