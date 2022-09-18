import 'package:rpsfest/model/event.dart';

class User {
  late String email;
  late String name;
  late String course;
  late String specialization; //bca no branch
  late String profilePhoto;
  List? registeredEvents;
  late bool isadmin;
  User(
      {required this.isadmin,
      required this.email,
      required this.name,
      required this.course,
      this.specialization = '',
      this.profilePhoto = '',
      this.registeredEvents});
  static Map<String, dynamic> tojson(User u) => {
        'email': u.email,
        'name': u.name,
        'course': u.course,
        'specialization': u.specialization,
        'profilePhoto': u.profilePhoto,
        'registerEvents': u.registeredEvents,
        'isAdmin': u.isadmin,
      };
  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        isadmin: json['isAdmin'],
        email: json['email'],
        name: json['name'],
        course: json['course'],
        specialization: json['specialization'],
        registeredEvents: json['registeredEvents'],
        profilePhoto: json['profilePhoto']);
  }
}
