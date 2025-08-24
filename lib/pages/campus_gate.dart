import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../theme/genz_theme.dart';
import 'package:flutter/services.dart' show rootBundle;

class CampusGate extends StatefulWidget {
  final Widget next;
  const CampusGate({super.key, required this.next});

  @override
  State<CampusGate> createState() => _CampusGateState();
}

class _CampusGateState extends State<CampusGate> {
  final _campusCtl = TextEditingController();
  final _idCtl = TextEditingController();
  bool _loading = true;
  bool _verified = false;
  Set<String> _allowed = {};
  String? _err;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final settings = Hive.box('settings');
    final campus = settings.get('campusId', defaultValue: '');
    if (campus.toString().isNotEmpty) {
      _campusCtl.text = campus;
    }
    await _loadAllowed();
    final user = Hive.box('user');
    _verified = user.get('verified', defaultValue: false);
    setState(() => _loading = false);
  }

  Future<void> _loadAllowed() async {
    final raw = await rootBundle.loadString('assets/allowed_ids.json');
    final data = json.decode(raw) as Map<String, dynamic>;
    final campus = _campusCtl.text.trim().isEmpty
        ? (Hive.box('settings').get('campusId', defaultValue: 'UNI-DEMO'))
        : _campusCtl.text.trim();
    final forCampus = (data[campus] ?? []) as List;
    _allowed = forCampus.map((e) => e.toString()).toSet();
  }

  Future<void> _saveCampus(String v) async {
    final id = v.trim().toUpperCase();
    await Hive.box('settings').put('campusId', id);
    await _loadAllowed();
    setState(() {});
  }

  Future<void> _verify() async {
    setState(() => _err = null);
    final campus = Hive.box(
      'settings',
    ).get('campusId', defaultValue: '').toString().trim();
    if (campus.isEmpty) {
      setState(() => _err = 'Enter campus code');
      return;
    }
    final id = _idCtl.text.trim().toUpperCase();
    if (id.isEmpty) {
      setState(() => _err = 'Enter your Student ID');
      return;
    }
    if (_allowed.contains(id)) {
      await Hive.box('user').put('verified', true);
      setState(() => _verified = true);
    } else {
      setState(
        () => _err =
            'ID not found for this campus. Ask admin to whitelist or check your campus code.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_verified) return widget.next;

    return Scaffold(
      appBar: const GZAppBar(
        titleText: 'UniVerse • Verify',
        logoAsset: 'assets/logo/universe_logo.png',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Choose your campus and verify with your Student ID. Only verified users can access activities.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _campusCtl,
              decoration: const InputDecoration(
                labelText: 'Campus Code (e.g., UNI-DEMO)',
              ),
              onChanged: (v) => _saveCampus(v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _idCtl,
              decoration: const InputDecoration(
                labelText: 'Student ID (from your ID card)',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _verify,
              icon: const Icon(Icons.verified_rounded),
              label: const Text('Verify & Continue'),
            ),
            if (_err != null) ...[
              const SizedBox(height: 10),
              Text(
                _err!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Admin? See Profile → Admin Tools to add IDs (local whitelist).',
            ),
          ],
        ),
      ),
    );
  }
}
