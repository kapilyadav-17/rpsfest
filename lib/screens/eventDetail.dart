import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/eventProvider.dart';

class EventDetail extends StatefulWidget {
  //const EventDetail({Key? key}) : super(key: key);
  static const routeName = '/eventDetail';
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //check if already registered
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    final eventId = args["eventId"];
    final eventDetail = Provider.of<EventProvider>(context).getEventDetails(eventId!);
    return Scaffold(
      appBar: AppBar(
        title: Text(eventDetail.eventName),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            child: Image.network(eventDetail.eventImage),
          ),
          SizedBox(height: 20,),
          Text(eventDetail.description),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: ()async{
              setState(() {
                isLoading=true;
              });
              try {
                if(eventDetail.participantsIds!=null){
                  eventDetail.participantsIds!.add(FirebaseAuth.instance.currentUser!.email);
                }
                else{
                  eventDetail.participantsIds = [FirebaseAuth.instance.currentUser!.email];
                }
                final DocumentReference docRef = FirebaseFirestore.instance.doc('events/${eventId}');
                await docRef.set({
                  'participantsIds' : eventDetail.participantsIds,
                },
                  SetOptions(merge: true),
                );
                final DocumentReference docRefUser = FirebaseFirestore.instance.doc('users/${FirebaseAuth.instance.currentUser!.uid}');
                //add to previous list it might be null
                await docRefUser.set({
                  'registeredEvents' : [eventId],
                },
                  SetOptions(merge: true),
                );
                setState(() {
                  isLoading=false;
                });
              } on Exception catch (e) {
                // TODO
                setState(() {
                  isLoading=false;
                });
                print(e.toString());
              }
            },
            child: isLoading?CircularProgressIndicator():Text('Register'),
          )
        ],
      ),
    );
  }
}
//store loggedInUser Details.....