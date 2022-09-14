import 'package:flutter/material.dart';
import 'package:rpsfest/screens/events.dart';

import 'home.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);
  static const routeName = '/tabsPage';
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _pageIndex = 0;
  Map<int, GlobalKey> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),

  };
  List pages =[
    Home(


    ),
    EventPage(

    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Events',
          ),

        ],
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(
                () {
              _pageIndex = index;
            },
          );
        },
      ),
      body: SafeArea(
        child: pages[_pageIndex],
      ),
    );
  }
}


// class Tabs extends StatefulWidget {
//   static const routeName = '/tabsPage';
//   @override
//   _TabsState createState() => _TabsState();
// }

// class _TabsState extends State<Tabs> {
//   int _pageIndex = 0;
//
//   Map<int, GlobalKey> navigatorKeys = {
//     0: GlobalKey(),
//     1: GlobalKey(),
//
//   };
//
//   get developer => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: WillPopScope(
//           onWillPop: () async {
//             developer.log(
//                 'On Will called ${navigatorKeys[_pageIndex]?.currentState?.context.widget}');
//             // return !await navigatorKeys[_pageIndex].currentState.context;
//             return !await Navigator.maybePop(
//                 navigatorKeys[_pageIndex]!.currentState!.context);
//             // Navigator.pop(navigatorKeys[_pageIndex].currentState.context);
//           },
//           child: IndexedStack(
//             index: _pageIndex,
//             children: <Widget>[
//               Home(
//
//                 navigatorKey: navigatorKeys[0]!,
//               ),
//               EventPage(
//                 navigatorKey: navigatorKeys[1]!,
//               ),
//
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label:'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Events',
//           ),
//
//         ],
//         currentIndex: _pageIndex,
//         onTap: (int index) {
//           setState(
//                 () {
//               _pageIndex = index;
//             },
//           );
//         },
//       ),
//     );
//   }
// }

/*
//IGNORE THIS CODE

class NavigatorPage extends StatefulWidget {
  NavigatorPage({required this.navigatorKey, required this.child});

  final Widget child;
  final GlobalKey navigatorKey;

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  late TextEditingController _textEditingController;

  int _currentRoute = 0;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(

              body:
            );
          },
        );
      },
    );
  }
}*/


/*
//IGNORE THIS CODE
class DetailRoute extends StatelessWidget {
  DetailRoute({required this.textEditingController, required this.index});

  final TextEditingController textEditingController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route for $index Item'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: TextField(controller: textEditingController),
      ),
    );
  }
}
*/


/*
//IGNORE THIS CODE
//TODO implement this when user account creation
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                    Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0,1],
                )
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Flexible(child: Container(
                    margin: EdgeInsets.only(bottom: 40,left: 10,right: 10,top: 20),
                    child: Text('Registration Form',
                      style: TextStyle(color: Colors.amberAccent,fontFamily: 'Anton',fontSize:30,fontWeight:FontWeight.normal ),),
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,

                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0,2),
                          )
                        ]
                    ),
                  )
                  ),
                  Flexible(child:RegisterFormCard() ,flex: deviceSize.width>600?2:1,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class RegisterFormCard extends StatefulWidget{
  const RegisterFormCard({Key? key}) : super(key: key);

  @override
  _RegisterFormCardState createState() => _RegisterFormCardState();
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String,String> authData ={
    'name':'',
    'rollNo':'',
    'phone':'',
    'course':'',
  };
  var isloading =false;
  Future<void> submit() async {
    if(!_formKey.currentState!.validate()){

      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });
    //apicall
    setState(() {
      isloading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ) ,
      elevation: 8,
      child: Container(
        height: 400,
        constraints:BoxConstraints(minHeight: 400) ,
        width: deviceSize.width*0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  //keyboardType: TextInputType.a,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Name';
                    }
                  },
                  onSaved: (value){
                    authData['name']=value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'rollno'),
                  keyboardType: TextInputType.text,

                  validator: (value){
                    if(value!.isEmpty ){
                      return 'Enter rollNo';
                    }
                  },

                  onSaved: (value){
                    authData['rollNo']=value!;
                  },
                ),
                TextFormField(

                  decoration: InputDecoration(labelText: 'course'),

                  validator:
                      (value){if( value!.isEmpty){return 'enter course name';}},

                ),
                TextFormField(

                    decoration: InputDecoration(labelText: 'phone'),
                    keyboardType: TextInputType.phone,
                    validator:
                        (value){if( value!.length!=10){return 'invalid phone number';}},

                  ),
                SizedBox(height: 20,),
                if(isloading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child: Text('Register'),
                    onPressed: submit,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ) ,
                    // padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),

                  ),


              ],
            ),
          ),
        ),

      ) ,
    );
  }
}
*/
/*

Card(
                        child: ListTile(
                          leading: FlutterLogo(),
                          title: Text('${index + 1} Item'),
                          enabled: true,
                          onTap: () {
                            if (_currentRoute != index) {
                              _textEditingController = TextEditingController();
                            }
                            _currentRoute = index;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return /*DetailRoute(
                                    textEditingController:
                                    _textEditingController,
                                    index: index,
                                  );*/
                                  RegistrationForm();
                                },
                              ),
                            );
                          },
                        ),
                      );
 */
