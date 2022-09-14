import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/provider/eventProvider.dart';
import 'package:rpsfest/screens/eventDetail.dart';

class EventBanner extends StatelessWidget {
  const EventBanner({Key? key,required this.eventId}) : super(key: key);
  final String eventId;
  @override
  Widget build(BuildContext context) {
    final eventDetail = Provider.of<EventProvider>(context).getEventDetails(eventId);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, EventDetail.routeName,arguments: {
              "eventId":eventId,
            });
          },

          child: Container(
          // decoration: BoxDecoration(
          // gradient: LinearGradient(
          // colors: [
          // Colors.black,
          // Colors.grey,//Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
          // ],
          // begin: Alignment.centerLeft,
          // end: Alignment.centerRight,
          // stops: [0, 0.5],
          // )),
            height: height*0.3,
            width: width,
            child: Image.network(eventDetail.eventImage),
          ),
        ),
        Positioned(child: Text(eventDetail.eventName,style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
        top: height*0.1,
        left: width*0.2,),
        Positioned(child: Container(
          width: width*0.5,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.start ,
            children: [
              Text('Explore',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),),
              SizedBox(width: 20,),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
          top: height*0.2,
          left: width*0.2,),

      ],
    );
  }
}

