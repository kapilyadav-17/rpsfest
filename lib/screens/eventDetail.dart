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
            onPressed: (){},
            child: Text('Register'),
          )
        ],
      ),
    );
  }
}
