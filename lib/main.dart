import 'dart:async';
import 'package:flutter/services.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/model/User.dart';
import 'package:rpsfest/provider/authapi.dart';
import 'package:rpsfest/provider/eventapi.dart';
import 'package:rpsfest/provider/tool.dart';
import 'package:rpsfest/provider/userapi.dart';
import 'package:rpsfest/screens/dummy.dart';
import 'package:rpsfest/screens/login.dart';
import 'package:rpsfest/screens/profilepage.dart';
import 'package:rpsfest/screens/events.dart';
import 'package:rpsfest/screens/splash.dart';
import 'package:rpsfest/screens/userdetail.dart';

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
              HomePage.routeName: (ctx) => HomePage(),
              UserDetailPage.routeName: (ctx) => UserDetail(),
              Splash.routeName : (ctx) => Splash(),
            }
        ));
  }
}

//
//
//
//
//
// class MyHomePage extends StatefulWidget {
//   //const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   final GlobalKey<ScaffoldMessengerState> snackbarKey =
//   GlobalKey<ScaffoldMessengerState>();
//   @override
//   void initState() {
//     super.initState();
//     initConnectivity();
//
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       print(e.message.toString());
//       return;
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//       if(_connectionStatus==ConnectivityResult.none){
//         snackbarKey.currentState!.showSnackBar(SnackBar(content: Text('offline')));
//
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: snackbarKey,
//       home: Scaffold(
//
//         appBar: AppBar(
//           title: const Text('Connectivity example app'),
//         ),
//         body: Center(
//             child: Text('Connection Status: ${_connectionStatus.toString()}')),
//       ),
//     );
//   }
// }