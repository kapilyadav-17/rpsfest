import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/screens/addEvent.dart';
import 'package:rpsfest/screens/viewParticipants.dart';

import '../model/event.dart';
import '../provider/eventProvider.dart';



class AdminEvents extends StatefulWidget {
  const AdminEvents({Key? key}) : super(key: key);
  static const routeName = '/adminEventsPage';
  @override
  _AdminEventsState createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  bool isDeleting = false;
  List<Event> eventsList = [];
  // static final default_appBar = AppBar(
  //   title: Text('Manage Events'),
  //   actions: [
  //     IconButton(
  //         onPressed: () {
  //           //profile
  //         },
  //         icon: Icon(
  //           Icons.person,
  //           color: Colors.black,
  //         ))
  //   ],
  // // );
  //  final new_appBar = AppBar(
  //   automaticallyImplyLeading: false,
  //   backgroundColor: Colors.green,
  //   actions: [
  //     IconButton(onPressed: (){
  //       setState(() {
  //
  //       });
  //     }, icon: Icon(Icons.delete,color: Colors.white,)),
  //   ],
  // );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  String? deleventId;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:isDeleting?
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed:(){
            Provider.of<EventProvider>(context,listen: false).removeEvent(deleventId!).then((value) {
              setState(() {
                isDeleting=false;

              });
            }).catchError((onError){
              setState(() {
                isDeleting=false;

              });
            });

          }, icon: Icon(Icons.delete,color: Colors.white,)),
        ],
      )
          :AppBar(
        title: Text('Manage Events'),
        actions: [
          IconButton(
              onPressed: () {
                //profile
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder<List<Event>>(
        stream: Provider.of<EventProvider>(context,listen: false).getEvents(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              eventsList = snapshot.data!;
              //print(eventsList);
              WidgetsBinding.instance.addPostFrameCallback((_){
                Provider.of<EventProvider>(context,listen: false).setEventsList(eventsList);
              });

            }
          }
          return SafeArea(
            child: Container(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,),
                    child: Row(
                      children: [
                        Expanded(child: Text('Events',style: TextStyle(
                          fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold
                        ),)),
                        ElevatedButton(onPressed: (){
                          Navigator.of(context).pushNamed(AddEvent.routeName);
                        }, child: Text('Add event')),
                      ],
                    ),
                  ),
                  Container(

                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    child: ListView.builder(

                      shrinkWrap: true,
                      itemBuilder: (context,index){

                      return Column(
                        children: [
                          Card(
                            elevation: 2,
                            child: ListTile(

                              leading: Container(
                                child: FadeInImage(
                                  placeholder: AssetImage('lib/images/pholder.png'),
                                  image: NetworkImage(eventsList[index].eventImage),
                                )

                              ),
                              title: Text(eventsList[index].eventName,style: TextStyle(
                                  fontSize: 22,color: Colors.blue
                              ),),
                              onLongPress: (){
                                setState(() {
                                  isDeleting=true;
                                });
                                deleventId=eventsList[index].eventId;
                              },
                              onTap: (){
                                Navigator.of(context).pushNamed( ViewParticipants.routeName,arguments: {
                                  "eventId":eventsList[index].eventId
                                });
                              },

                              minLeadingWidth: MediaQuery.of(context).size.width*0.4,
                              //swipe discard,deleteicon,longpress
                            ),
                          ),
                          SizedBox(height: 5,),
                        ],
                      );
                    },itemCount: eventsList.length ,),
                  )
                ],
              )
            ),
          );
        }
      ),
    );
  }
}
