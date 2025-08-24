
import 'package:flutter/material.dart'; import '../models/post.dart'; import 'glass_card.dart';
class PostCard extends StatelessWidget {
  final Post post; const PostCard({super.key, required this.post});
  IconData _icon(){ switch(post.type){ case 'ride': return Icons.directions_car_rounded; case 'lost': return Icons.search_rounded; case 'found': return Icons.check_circle_rounded; case 'sale': return Icons.local_mall_rounded; default: return Icons.chat_bubble_rounded; } }
  @override Widget build(BuildContext context){
    return GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      Row(children:[Icon(_icon(), color: Theme.of(context).colorScheme.primary), const SizedBox(width:8), Expanded(child: Text(post.title, style: Theme.of(context).textTheme.titleMedium)), Text(post.createdAt.toLocal().toIso8601String().substring(0,10), style: Theme.of(context).textTheme.labelSmall)]),
      const SizedBox(height:6), Text(post.content, maxLines:3, overflow: TextOverflow.ellipsis),
      const SizedBox(height:8), Row(children:[const Icon(Icons.person, size:16), const SizedBox(width:4), Text(post.author), const SizedBox(width:12), const Icon(Icons.call, size:16), const SizedBox(width:4), Text(post.contact)]) ]));
  }
}
