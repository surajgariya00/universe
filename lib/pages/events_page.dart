
import 'package:flutter/material.dart'; import '../services/event_repo.dart'; import '../services/club_repo.dart';
import '../models/event.dart'; import '../widgets/event_card.dart';
class EventsPage extends StatefulWidget { const EventsPage({super.key}); @override State<EventsPage> createState()=>_EventsPageState(); }
class _EventsPageState extends State<EventsPage> {
  bool _loading=true; List<Event> _events=[]; String _query=''; String? _clubFilter;
  @override void initState(){ super.initState(); _load(); }
  Future<void> _load() async { setState(()=>_loading=true); final events=await EventRepo.all(); setState((){ _events=events; _loading=false; }); }
  @override Widget build(BuildContext context){
    return SafeArea(child: Column(children:[
      Padding(padding: const EdgeInsets.fromLTRB(12,12,12,8), child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search events…'), onChanged: (v)=> setState(()=> _query=v.toLowerCase()))),
      FutureBuilder(future: ClubRepo.all(), builder: (context,snap){
        final clubs = snap.data ?? []; return SingleChildScrollView(padding: const EdgeInsets.only(left:10, bottom:8), scrollDirection: Axis.horizontal, child: Row(children: [
          ChoiceChip(label: const Text('All'), selected: _clubFilter==null, onSelected: (_)=> setState(()=> _clubFilter=null)),
          const SizedBox(width:6),
          ...clubs.map<Widget>((c)=> Padding(padding: const EdgeInsets.symmetric(horizontal:4), child: ChoiceChip(label: Text(c.name), selected: _clubFilter==c.id, onSelected: (_)=> setState(()=> _clubFilter=c.id))))
        ]));
      }),
      Expanded(child: _loading? const Center(child:CircularProgressIndicator()) : RefreshIndicator(onRefresh:_load, child: ListView(children: _events.where((e){
        final hay=(e.title+e.location+e.description).toLowerCase(); final matchesQ = _query.isEmpty || hay.contains(_query); final matchesC = _clubFilter==null || e.clubId==_clubFilter; return matchesQ && matchesC;
      }).map((e)=> EventCard(event:e)).toList()))),
    ]));
  }
}
