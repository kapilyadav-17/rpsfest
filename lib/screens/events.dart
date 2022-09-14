import 'package:flutter/material.dart';
import 'package:rpsfest/widgets/eventbanner.dart';

class EventPage extends StatefulWidget {
  EventPage({required this.navigatorKey});


  final GlobalKey navigatorKey;
  static const routeName = '/eventsPage';
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(itemBuilder: (ctx,i)=>Column(children: [EventBanner(),SizedBox(height: 4,)],),itemCount:2 ),
      ),

    );
  }
}
