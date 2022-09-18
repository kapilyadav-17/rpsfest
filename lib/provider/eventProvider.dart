import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../model/User.dart';
import '../model/event.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EventProvider with ChangeNotifier{
  //var uuid = Uuid();
  List<Event> events = [Event(eventId: 'e1', eventName: 'Coding', eventImage: 'https://th.bing.com/th/id/R.56f79bbb84f18c91ba1e12c271dcf383?rik=OkYaX%2fcru%2fH2YQ&riu=http%3a%2f%2fdesigndrizzle.com%2fwp-content%2fuploads%2ffeatured_code.jpg&ehk=YY3AZOfMyAygyIUJCNSdVMZeWSQC1jvaX8MKbsd3xyk%3d&risl=&pid=ImgRaw&r=0',
      description: "coding competition for nerds",participantsIds: ['kapilyadav9127@gmail.com']),
    Event(eventId: 'e2', eventName: 'Construction', eventImage: 'https://th.bing.com/th/id/R.56f79bbb84f18c91ba1e12c271dcf383?rik=OkYaX%2fcru%2fH2YQ&riu=http%3a%2f%2fdesigndrizzle.com%2fwp-content%2fuploads%2ffeatured_code.jpg&ehk=YY3AZOfMyAygyIUJCNSdVMZeWSQC1jvaX8MKbsd3xyk%3d&risl=&pid=ImgRaw&r=0',
        description: "civil engineering competition",participantsIds: ['kapilyadav9127@gmail.com','kapilyadav9128@gmail.com'])];

  List<Event> get getEventsList=> events;
  void setEventsList(List<Event> newEventsList){
    events=newEventsList;
    notifyListeners();
  }
  Stream<List<Event>> getEvents(){
    try {
      final collectionRef = FirebaseFirestore.instance.collection('events');
      return collectionRef.snapshots().map(
          (QuerySnapshot querySnapshot){
            return querySnapshot.docs.map(
                (QueryDocumentSnapshot snapshot){
                  final Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;
                  final List Ids = data['participantsIds'] ;
                  //print(data);
                  //print(Ids);
                  //List<String> List/?/
                  return Event.fromjson(data);

                }
            ).toList();
          }
      );
      // newEventList.forEach((element) {
      //   print(element.eventId);
      //   print(element.eventName);
      // });
      // events= events + newEventList;

    } on Exception catch (e) {
      print(e.toString());
      // TODO
      throw(e);
    }
    notifyListeners();
  }

  Future<void> addEvent(Map<String,dynamic> eventData)async{
    //var eventId = uuid.v4();
    //eventData['eventId']=eventId;
    Event newEvent = Event(eventId: eventData['eventId'], eventName: eventData['eventName'], eventImage: eventData['eventImage'], description: eventData['description'],participantsIds: eventData['participantsIds']);
    //fb call
    print(newEvent.participantsIds);
    try {

      await FirebaseFirestore.instance.collection('events').doc(newEvent.eventId).set(Event.toJson(newEvent));
      events.add(newEvent);
    } on Exception catch (e) {
      rethrow;
    }
    //try rethrow
    //add  to events
    notifyListeners();

  }
  Future<void> removeEvent(String eventId)async{
    try {
      final ref = FirebaseStorage.instance.ref().child('eventImages').child(eventId+'.jpeg');
      await ref.delete();
      final docRef = FirebaseFirestore.instance.collection('events').doc(eventId);
      await docRef.delete();
      events.removeWhere((element) => element.eventId==eventId);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    notifyListeners();
  }

  Event getEventDetails(String eventId){
    return events.firstWhere((element) => element.eventId==eventId);
  }
  
  Stream<List<User>> getparticipantsofEvent(List Ids){
    final Query query = FirebaseFirestore.instance.collection('users').where('email',whereIn: Ids);
    return query.snapshots().map(
        (QuerySnapshot querysnapshot){
          return querysnapshot.docs.map(
              (QueryDocumentSnapshot snapshot){
                final Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;
                //print(data);
                return User.fromjson(data);

              }
          ).toList();
        }
    );
  }

  //fetch
  //update (admin)
  //update participant list
}