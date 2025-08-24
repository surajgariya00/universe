
class Club {
  final String id; final String name; final String category; final String description; final int members;
  Club({required this.id, required this.name, required this.category, required this.description, required this.members});
  factory Club.fromMap(Map<String, dynamic> m)=>Club(id:m['id'],name:m['name'],category:m['category'],description:m['description']??'',members:m['members']??0);
  Map<String, dynamic> toMap()=>{'id':id,'name':name,'category':category,'description':description,'members':members};
}
