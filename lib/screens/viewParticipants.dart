import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/User.dart';
import '../provider/eventProvider.dart';

class ViewParticipants extends StatefulWidget {
  const ViewParticipants({Key? key}) : super(key: key);
  static const routeName = '/viewParticipants';

  @override
  _ViewParticipantsState createState() => _ViewParticipantsState();
}

class _ViewParticipantsState extends State<ViewParticipants> {
  List<User> getParticpantsList(List<String> participantIds){
    //fetch detail for each id
    List<User> returnList=[];
    List<User> allUsers = [User(name: 'Kapil Yadav',course: "Btech",specialization: "Cse",email: "kapilyadav9127@gmail.com",profilePhoto: 'https://cdn4.vectorstock.com/i/1000x1000/77/43/young-man-head-avatar-cartoon-face-character-vector-21757743.jpg',registeredEvents: null,isadmin: true)
                            ,User(name: 'Bhola',course: "Btech",specialization: "Civil",email: "kapilyadav9128@gmail.com",profilePhoto: 'https://cdn4.vectorstock.com/i/1000x1000/77/43/young-man-head-avatar-cartoon-face-character-vector-21757743.jpg',registeredEvents: null,isadmin: false)];
    participantIds.forEach((element) {
      returnList.add(
        allUsers.firstWhere((e) => e.email==element)
      );
    });
    return returnList;
  }

  void descriptionOnPressed(){

      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          isDismissible: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
          ),
          builder: (builder){
            return  SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),

                    color: Colors.white,

                  ),
                  height: 150.0,

                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          alignment: Alignment.center,
                          child: TextFormField(
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            decoration: InputDecoration(

                                hintText: 'Change Event Description'
                            ),
                          ),
                        ),

                        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Save')),
                      ],
                    ),
                  )
              ),
            );
          }
      );

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    final eventId = args["eventId"];
    final eventDetail = Provider.of<EventProvider>(context).getEventDetails(eventId!);
    //need to fetch user detail for each participant id
    //paging..concept
    List<User> participants=[];
    // if(eventDetail.participantsIds!=null){
    //    participants = getParticpantsList(eventDetail.participantsIds!);
    // }
    //print(eventDetail.participantsIds);
    return Scaffold(
      appBar: AppBar(
        title: Text(eventDetail.eventName),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                    ),
                    builder: (builder){
                      return  SingleChildScrollView(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),

                            color: Colors.white,

                          ),
                          height: 150.0,

                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                   Container(
                                     width: MediaQuery.of(context).size.width*0.6,
                                     child: TextFormField(

                                      decoration: InputDecoration(
                                        hintText: 'Change Event Name'
                                      ),
                                  ),
                                   ),

                                TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Save')),
                              ],
                            ),
                          )
                        ),
                      );
                    }
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: Provider.of<EventProvider>(context,listen: false).getparticipantsofEvent(eventDetail.participantsIds!),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              participants=snapshot.data!;
              print(participants);
            }
          }
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),

                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        width: MediaQuery.of(context).size.width*0.8,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width*0.7,
                        child: FadeInImage(
                          placeholder: AssetImage('lib/images/pholder.png'),
                          image: NetworkImage(eventDetail.eventImage),
                        ),

                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 3)
                        ),
                      ),
                      Positioned(child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.pink,size: 40,)),
                        right: 0,
                        top: 0,
                      ),
                    ],
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        IconButton(onPressed: descriptionOnPressed, icon: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                    child: Text(eventDetail.description),
                  ),
                  SizedBox(height: 20,),
                  eventDetail.participantsIds==null?
                      Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                        alignment: Alignment.centerLeft,child: Text("No Participants Yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)
                  : Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                    alignment: Alignment.centerLeft,child: Text("Participants List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
                    if (eventDetail.participantsIds!=null) Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                    //download this list as pdf
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            elevation: 3,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.network(participants[index].profilePhoto,),
                                radius: 25,

                              ),
                              title: Text(participants[index].name + ' ('+ '${participants[index].course}'+' '+'${participants[index].specialization}'+' )'),
                              subtitle: Text(participants[index].email),
                              minLeadingWidth: 45,
                              isThreeLine: true,
                              // trailing: Container(
                              //   //width: 50,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(participants[index].course),
                              //       SizedBox(width: 2,),
                              //       Text(participants[index].specialization),
                              //     ],
                              //   ),
                              // ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text(participants[index].course),
                          //     SizedBox(width: 5,),
                          //     Text(participants[index].specialization),
                          //   ],
                          // ),
                          SizedBox(height: 5,),
                        ],
                      );
                    },
                      itemCount: participants.length,),
                    ),



                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
