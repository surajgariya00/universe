
import 'package:flutter/material.dart';
import '../services/post_repo.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';
import 'package:uuid/uuid.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});
  @override State<MarketplacePage> createState()=>_MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  bool _loading=true; List<Post> _posts=[]; String _filter='all';

  @override void initState(){ super.initState(); _load(); }
  Future<void> _load() async {
    setState(()=>_loading=true);
    final posts=await PostRepo.all();
    setState((){ _posts=posts; _loading=false; });
  }

  void _newPostDialog(){
    final form = GlobalKey<FormState>();
    String type='ride', title='', content='', author='anon', contact='';
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('New post'),
        content: SingleChildScrollView(child: Form(key: form, child: Column(mainAxisSize: MainAxisSize.min, children: [
          DropdownButtonFormField<String>(value: type, decoration: const InputDecoration(labelText: 'Type'), items: const [
            DropdownMenuItem(value: 'ride', child: Text('Ride Share')),
            DropdownMenuItem(value: 'sale', child: Text('For Sale')),
            DropdownMenuItem(value: 'lost', child: Text('Lost')),
            DropdownMenuItem(value: 'found', child: Text('Found')),
          ], onChanged: (v)=> type = v ?? 'ride'),
          TextFormField(decoration: const InputDecoration(labelText: 'Title'), onChanged: (v)=> title=v),
          TextFormField(decoration: const InputDecoration(labelText: 'Details'), onChanged: (v)=> content=v, maxLines: 4),
          TextFormField(decoration: const InputDecoration(labelText: 'Your name (optional)'), onChanged: (v)=> author=v),
          TextFormField(decoration: const InputDecoration(labelText: 'Contact (phone/email)'), onChanged: (v)=> contact=v),
        ]))),
        actions: [
          TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () async {
            final p = Post(id: const Uuid().v4(), type: type, title: title, content: content, author: author.isEmpty? 'anon': author, contact: contact, createdAt: DateTime.now().toUtc());
            await PostRepo.add(p); if(context.mounted) Navigator.pop(context); _load();
          }, child: const Text('Post'))
        ],
      );
    });
  }

  @override Widget build(BuildContext context){
    final tabs = {'all': Icons.apps_rounded, 'ride': Icons.directions_car_rounded, 'sale': Icons.local_mall_rounded, 'lost': Icons.search_rounded, 'found': Icons.check_circle_rounded};
    return SafeArea(child: Column(children:[
      Padding(padding: const EdgeInsets.fromLTRB(12,12,12,8), child: Row(children: tabs.entries.map((e)=> Padding(padding: const EdgeInsets.only(right:8), child: ChoiceChip(label: Row(children:[Icon(e.value, size:18), const SizedBox(width:6), Text(e.key)]), selected: _filter==e.key, onSelected: (_)=> setState(()=> _filter=e.key)))).toList())),
      Expanded(child: _loading? const Center(child: CircularProgressIndicator()) : RefreshIndicator(onRefresh: _load, child: ListView(children: _posts.where((p)=> _filter=='all' || p.type==_filter).map((p)=> PostCard(post:p)).toList()))),
      const SizedBox(height: 8),
      Padding(padding: const EdgeInsets.only(bottom:12), child: FloatingActionButton.extended(onPressed: _newPostDialog, icon: const Icon(Icons.add), label: const Text('New'))),
    ]));
  }
}
