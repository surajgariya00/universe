
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';
import '../widgets/seed_color_picker.dart';
import 'package:provider/provider.dart';
import '../controllers/app_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override State<ProfilePage> createState()=>_ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _name, _email, _college, _year, _bio;

  @override void initState(){
    super.initState();
    final box = Hive.box('user');
    final m = Map<String, dynamic>.from(box.get('profile', defaultValue: {}));
    final u = m.isEmpty ? UserProfile.empty() : UserProfile.fromMap(m);
    _name = TextEditingController(text: u.name);
    _email = TextEditingController(text: u.email);
    _college = TextEditingController(text: u.college);
    _year = TextEditingController(text: u.year);
    _bio = TextEditingController(text: u.bio);
  }

  Future<void> _save() async {
    final u = UserProfile(name: _name.text.trim().isEmpty?'You':_name.text.trim(), email: _email.text.trim(), college: _college.text.trim(), year: _year.text.trim(), bio: _bio.text.trim());
    await Hive.box('user').put('profile', u.toMap());
    if(mounted){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved locally ✓'))); }
  }

  @override Widget build(BuildContext context){
    final app = context.watch<AppState>();
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[
      Text('Your Profile', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height:12),
      TextField(controller:_name, decoration: const InputDecoration(labelText:'Name')),
      const SizedBox(height:8),
      TextField(controller:_email, decoration: const InputDecoration(labelText:'Email (optional)')),
      const SizedBox(height:8),
      TextField(controller:_college, decoration: const InputDecoration(labelText:'College')),
      const SizedBox(height:8),
      TextField(controller:_year, decoration: const InputDecoration(labelText:'Year/Batch')),
      const SizedBox(height:8),
      TextField(controller:_bio, maxLines:4, decoration: const InputDecoration(labelText:'Bio')),
      const SizedBox(height:16),
      Text('Theme', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height:8),
      const SeedColorPicker(),
      const SizedBox(height:8),
      ElevatedButton.icon(onPressed: ()=> context.read<AppState>().toggleDark(), icon: const Icon(Icons.brightness_6_rounded), label: Text(app.dark? 'Dark mode: ON':'Dark mode: OFF')),
      const SizedBox(height:20),
      ElevatedButton.icon(onPressed: _save, icon: const Icon(Icons.save_rounded), label: const Text('Save')),
      const SizedBox(height:24),
      Text('Admin Tools', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height:8),
      const Text('Add local whitelist IDs (demo). This does not edit bundled assets. Use for testing without editing JSON.'),
    ]));
  }
}


class _AdminPanel extends StatefulWidget {
  const _AdminPanel();
  @override
  State<_AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<_AdminPanel> {
  final _idCtl = TextEditingController();
  List<String> _local = [];

  @override
  void initState(){ super.initState(); _load(); }
  Future<void> _load() async {
    final box = Hive.box('settings');
    final list = List<String>.from(box.get('local_ids', defaultValue: <String>[]));
    setState(()=> _local = list);
  }
  Future<void> _add() async {
    final v = _idCtl.text.trim().toUpperCase();
    if (v.isEmpty) return;
    final box = Hive.box('settings');
    final list = List<String>.from(box.get('local_ids', defaultValue: <String>[]));
    if (!list.contains(v)) list.add(v);
    await box.put('local_ids', list);
    _idCtl.clear();
    _load();
  }
  @override
  Widget build(BuildContext context){
    return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Admin Tools', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      TextField(controller: _idCtl, decoration: const InputDecoration(labelText: 'Add Student ID to LOCAL whitelist')),
      const SizedBox(height: 8),
      ElevatedButton.icon(onPressed: _add, icon: const Icon(Icons.add), label: const Text('Add')),
      const SizedBox(height: 8),
      Wrap(spacing: 8, children: _local.map((e)=> Chip(label: Text(e))).toList()),
    ])));
  }
}
