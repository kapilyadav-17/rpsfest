

import 'package:flutter/material.dart';
import 'package:rpsfest/screens/login.dart';
import 'package:rpsfest/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const routeName = '/profilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService.instance;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                icon: Icon(Icons.close),

              )],
            ),
            SizedBox(height: 20,),
            CircleAvatar(
              backgroundColor: Colors.pink,
              child: Text('KY'),
              radius: 50,
            ),
            SizedBox(height: 20,),
            Text(('Kapil Yadav')),
            SizedBox(height: 20,),
            Text('kapilyadav9127@gmail.com'),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(bottom: 20,left: 10,right: 10,top: 10),
              alignment: Alignment.center,
              child: Text('Events',style: TextStyle(fontSize: 20),),
              width: deviceSize.width*0.7,

              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade100,
                  border: Border.all(color: Colors.black,width: 1),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black26,
                      offset: Offset(0,2),
                    )
                  ]
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: ()async{
                _authService.fbauth.signOut();
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
