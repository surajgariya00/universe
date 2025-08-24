import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../services/event_repo.dart';
import '../services/post_repo.dart';
import '../widgets/event_card.dart';
import '../widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool _loading = true;
  List<dynamic> _items = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final events = await EventRepo.all();
    final posts = await PostRepo.all();
    final items = <Map<String, dynamic>>[];
    for (final e in events) {
      items.add({'type': 'event', 'time': e.start, 'data': e});
    }
    for (final p in posts) {
      items.add({'type': 'post', 'time': p.createdAt, 'data': p});
    }
    items.sortBy((e) => (e['time'] as DateTime));
    items.reversed;
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _load,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _items.length,
                  itemBuilder: (context, i) {
                    final it = _items[i];
                    if (it['type'] == 'event') {
                      return EventCard(event: it['data']);
                    } else {
                      return PostCard(post: it['data']);
                    }
                  },
                ),
              ),
      ),
    );
  }
}
