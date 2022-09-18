import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/widgets/eventbanner.dart';

import '../model/event.dart';
import '../provider/eventProvider.dart';

class EventPage extends StatefulWidget {
  //EventPage({required this.navigatorKey});

  //final GlobalKey navigatorKey;
  static const routeName = '/eventsPage';
  @override
  _EventPageState createState() => _EventPageState();
}
class _EventPageState extends State<EventPage> {
  List<Event> eventsList = [];
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Event>>(
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
        return Scaffold(
            appBar: AppBar(
              title: Text('Events'),
            ),
            body: ListView.builder(
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    SizedBox(height: 5,),
                    EventBanner(eventId: eventsList[index].eventId),

                  ],
                );
              }),
              itemCount: eventsList.length,
            ));
      }
    );
  }
}
// class _EventPageState extends State<EventPage> {
//   int _currentRoute = 0;
//   @override
//   Widget build(BuildContext context) {
//     final eventsList = Provider.of<EventProvider>(context).getEventsList;
//     return Navigator(
//       key: widget.navigatorKey,
//       onGenerateRoute: (RouteSettings settings) {
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (BuildContext context) {
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text('Events'),
//                 ),
//                 body: ListView.builder(
//                   itemBuilder: ((context, index) {
//                     return Column(
//                       children: [
//                         SizedBox(height: 5,),
//                         EventBanner(eventId: eventsList[index].eventId),
//
//                       ],
//                     );
//                   }),
//                   itemCount: eventsList.length,
//                 ));
//           },
//         );
//       },
//     );
//   }
// }
