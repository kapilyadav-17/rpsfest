import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/screens/tabs.dart';
import 'package:rpsfest/services/auth.dart';

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
    Future.delayed(Duration(milliseconds: 2000),(){
      if(_authService.currentUser!=null){
        //print(_authService.currentUser.)
        Navigator.pushReplacementNamed(context, Tabs.routeName);
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
