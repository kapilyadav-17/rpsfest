
class Event{
  final String eventId;
  late String eventName;
  late List<String>? participantsIds;
  late String eventImage;
  late String description;

  Event({required this.eventId,required this.eventName,required this.eventImage,required this.description,this.participantsIds});




}

//admin view = add/delete event ,participants detail
//new apk? ??