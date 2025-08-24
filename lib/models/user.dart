
class UserProfile {
  final String name; final String email; final String college; final String year; final String bio;
  UserProfile({required this.name, required this.email, required this.college, required this.year, required this.bio});
  factory UserProfile.empty()=>UserProfile(name:'You',email:'',college:'',year:'',bio:'');
  factory UserProfile.fromMap(Map<String, dynamic> m)=>UserProfile(name:m['name']??'You',email:m['email']??'',college:m['college']??'',year:m['year']??'',bio:m['bio']??'');
  Map<String, dynamic> toMap()=>{'name':name,'email':email,'college':college,'year':year,'bio':bio};
}
