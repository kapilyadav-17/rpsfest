
import '../model/event.dart';
import 'package:flutter/material.dart';
class EventProvider with ChangeNotifier{
  List<Event> events = [];

  List<Event> get getEventsList=> events;

  void getAllEevents(){

  }
  void addEvent(Event newEvent){

  }
  void removeEvent(String eventId){

  }
  void participantListOfAnEvent(String eventId){

  }


  //fetch
  //update (admin)
  //update participant list
}