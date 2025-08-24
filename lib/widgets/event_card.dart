
import 'package:flutter/material.dart';
import '../models/event.dart'; import 'glass_card.dart';
class EventCard extends StatelessWidget {
  final Event event; final VoidCallback? onTap;
  const EventCard({super.key, required this.event, this.onTap});
  @override Widget build(BuildContext context){
    final dt = TimeOfDay.fromDateTime(event.start);
    return GlassCard(child: InkWell(onTap:onTap, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
      Row(children:[Icon(Icons.event, color: Theme.of(context).colorScheme.primary), const SizedBox(width:8), Expanded(child: Text(event.title, style: Theme.of(context).textTheme.titleMedium)), Text(dt.format(context))]),
      const SizedBox(height:6), Text(event.location, style: Theme.of(context).textTheme.labelMedium),
      const SizedBox(height:8), Wrap(spacing:6, children: event.tags.map((t)=>Chip(label: Text(t))).toList()),
    ])));
  }
}
