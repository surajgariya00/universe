
class Slot {
  final String day; final String subject; final String start; final String end; final String room;
  Slot({required this.day, required this.subject, required this.start, required this.end, required this.room});
  factory Slot.fromMap(Map<String, dynamic> m)=>Slot(day:m['day'],subject:m['subject'],start:m['start'],end:m['end'],room:m['room']??'');
  Map<String, dynamic> toMap()=>{'day':day,'subject':subject,'start':start,'end':end,'room':room};
}
