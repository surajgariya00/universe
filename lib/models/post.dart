
class Post {
  final String id; final String type; final String title; final String content; final String author; final String contact; final DateTime createdAt; final String? meta;
  Post({required this.id, required this.type, required this.title, required this.content, required this.author, required this.contact, required this.createdAt, this.meta});
  factory Post.fromMap(Map<String, dynamic> m)=>Post(id:m['id'],type:m['type'],title:m['title'],content:m['content'],author:m['author']??'anon',contact:m['contact']??'',createdAt:DateTime.parse(m['createdAt']),meta:m['meta']);
  Map<String, dynamic> toMap()=>{'id':id,'type':type,'title':title,'content':content,'author':author,'contact':contact,'createdAt':createdAt.toIso8601String(),'meta':meta};
}
