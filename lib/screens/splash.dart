import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/screens/adminEvents.dart';
import 'package:rpsfest/screens/tabs.dart';
import 'package:rpsfest/screens/userdetail.dart';
import 'package:rpsfest/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider/tool.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  //const Splash({Key? key}) : super(key: key);
  static const routeName = '/splashroute';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final AuthService _authService = AuthService.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Tool>(context,listen: false).checkConnectivity();
    Future.delayed(Duration(milliseconds: 2000),()async{
      if(_authService.currentUser!=null){
        //print(_authService.currentUser.)
        final docRef = await FirebaseFirestore.instance.collection('/users').doc(_authService.currentUser!.uid);
        final isExist = await FirebaseFirestore.instance.collection('/users').doc(_authService.currentUser!.uid).get();

        if(isExist.exists){
          docRef.get().then((DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            if(data['isAdmin']){
              Navigator.pushReplacementNamed(context, AdminEvents.routeName);
            }
            else{
              Navigator.pushReplacementNamed(context, Tabs.routeName);
            }
          },
            onError: (e) => print("Error getting document: $e"),
          );


        }
        else{
          Navigator.pushReplacementNamed(context, UserDetailPage.routeName);
        }
      }
      else{
        Navigator.pushReplacementNamed(context, Login.routeName);
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
        Text("Splash Screen......"),),
    );
  }
}
