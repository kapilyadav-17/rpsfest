
import 'package:rpsfest/model/event.dart';

class User {
  late String email;
  late String name;
  late String course;
  late String specialization;//bca no branch
  late String profilePhoto;
  List<Event>? registeredEvents;
  late bool isadmin;
  User({required this.isadmin,required this.email,required this.name,required this.course, this.specialization='',this.profilePhoto='',this.registeredEvents});

}