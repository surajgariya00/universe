
class Event {
  final String id; final String title; final String clubId; final String location; final DateTime start; final DateTime end; final List<String> tags; final String description;
  Event({required this.id, required this.title, required this.clubId, required this.location, required this.start, required this.end, required this.tags, required this.description});
  factory Event.fromMap(Map<String, dynamic> m) => Event(id: m['id'], title: m['title'], clubId: m['clubId'], location: m['location'], start: DateTime.parse(m['start']), end: DateTime.parse(m['end']), tags: List<String>.from(m['tags'] ?? []), description: m['description'] ?? '');
  Map<String, dynamic> toMap()=>{'id':id,'title':title,'clubId':clubId,'location':location,'start':start.toIso8601String(),'end':end.toIso8601String(),'tags':tags,'description':description};
}
