
import '../model/event.dart';
import 'package:flutter/material.dart';
class EventProvider with ChangeNotifier{
  List<Event> events = [Event(eventId: 'e1', eventName: 'Coding', eventImage: 'https://th.bing.com/th/id/R.56f79bbb84f18c91ba1e12c271dcf383?rik=OkYaX%2fcru%2fH2YQ&riu=http%3a%2f%2fdesigndrizzle.com%2fwp-content%2fuploads%2ffeatured_code.jpg&ehk=YY3AZOfMyAygyIUJCNSdVMZeWSQC1jvaX8MKbsd3xyk%3d&risl=&pid=ImgRaw&r=0',
      description: "coding competition for nerds",participantsIds: null)];

  List<Event> get getEventsList=> events;


  void addEvent(Event newEvent){

  }
  void removeEvent(String eventId){

  }
  void participantListOfAnEvent(String eventId){

  }
  Event getEventDetails(String eventId){
    return events.firstWhere((element) => element.eventId==eventId);
  }


  //fetch
  //update (admin)
  //update participant list
}