import 'dart:async';
import 'package:flutter/services.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/model/User.dart';
import 'package:rpsfest/provider/authapi.dart';
import 'package:rpsfest/provider/eventProvider.dart';
import 'package:rpsfest/provider/tool.dart';
import 'package:rpsfest/provider/userProvider.dart';
import 'package:rpsfest/screens/addEvent.dart';
import 'package:rpsfest/screens/adminEvents.dart';
import 'package:rpsfest/screens/tabs.dart';
import 'package:rpsfest/screens/eventDetail.dart';
import 'package:rpsfest/screens/login.dart';
import 'package:rpsfest/screens/profilepage.dart';
import 'package:rpsfest/screens/events.dart';
import 'package:rpsfest/screens/splash.dart';
import 'package:rpsfest/screens/userdetail.dart';
import 'package:rpsfest/screens/viewParticipants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
// void main() async{
//   runApp(const MyApp());
// }
class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create:(context) => Auth(),),
          ChangeNotifierProvider(create: (context)=>UserProvider()),
          ChangeNotifierProvider(create: (context)=>EventProvider()),
          ChangeNotifierProvider(create: (context)=>Tool()),
        ],
        child:MaterialApp(
            title: 'TechFest',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            home:FutureBuilder(
              future: _fbApp,
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()));
                }
                else if(snapshot.hasData){
                  return Splash();
                }
                else{
                  return Scaffold(body: Center(child: CircularProgressIndicator(),));
                }
              },
            ) ,
            // home: Login(),
            routes:{
              Login.routeName: (ctx) => Login(),
              ProfilePage.routeName: (ctx) => ProfilePage(),
              //Events.routeName: (ctx) => Events(),
              Tabs.routeName: (ctx) => Tabs(),
              UserDetailPage.routeName: (ctx) => UserDetailPage(),
              Splash.routeName : (ctx) => Splash(),
              EventDetail.routeName: (ctx)=>EventDetail(),
              AdminEvents.routeName : (ctx)=>AdminEvents(),
              ViewParticipants.routeName: (ctx)=> ViewParticipants(),
              AddEvent.routeName: (ctx)=> AddEvent(),
            }
        ));
  }
}

/*
  // IGNORE THIS CODE
  //TODO implemnt dispose in Splash
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
*/