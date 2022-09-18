import 'dart:convert';

class Event {
  final String eventId;
  late String eventName;
  late List? participantsIds;
  late String eventImage;
  late String description;

  Event(
      {required this.eventId,
      required this.eventName,
      required this.eventImage,
      required this.description,
      this.participantsIds});
  factory Event.fromjson(Map<String, dynamic> json) {
    return Event(
        eventId: json['eventId'],
        eventName: json['eventName'],
        eventImage: json['eventImage'],
        description: json['description'],
        participantsIds: json['participantsIds']
    );
  }
//remove factory
  static Map<String, dynamic> toJson(Event e) => {
        'eventId': e.eventId,
        'eventName': e.eventName,
        'eventImage': e.eventImage,
        'description': e.description,
        'participantsIds': e.participantsIds,
      };
}

// Event Eventjson(String str) =>
//     Event.fromJson(json.decode(str));

//admin view = add/delete event ,participants detail
//new apk? ??
