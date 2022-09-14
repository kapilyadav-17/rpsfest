import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/screens/dummy.dart';
import 'package:rpsfest/screens/userdetail.dart';
import 'package:rpsfest/services/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../provider/authapi.dart';
import '../provider/tool.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  static const routeName = '/loginPage';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
              stops: [0, 1],
            )),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: Text(
                      'TechFest',
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontFamily: 'Anton',
                          fontSize: 50,
                          fontWeight: FontWeight.normal),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ]),
                  )),
                  Flexible(
                    child: AuthCard(),
                    flex: deviceSize.width > 600 ? 2 : 1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthService _authService = AuthService.instance;
  StreamSubscription<User?>? _authChangeSubscription;
  AuthMode authMode = AuthMode.Login;
  TextEditingController otpcontroller = TextEditingController();
  Map<String, String> authData = {'phone': '', 'password': ''};
  var verificationId;
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    // TODO: implement initState
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('offline')));
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.ethernet){
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.bluetooth){
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
    _authChangeSubscription = _authService.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushNamed(context, HomePage.routeName);
      }
    });
  }
  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }
  var isloading = false;
  final passcontroller = TextEditingController();

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading = true;
    });
    if (authMode == AuthMode.Login) {
      Navigator.of(context).pushNamed(UserDetailPage.routeName);
    } else {
      //await Provider.of<Auth>(context,listen: false).SignUp(authData['phone']!, authData['password']!);
      Navigator.of(context).pushNamed(UserDetailPage.routeName);
    }
    setState(() {
      isloading = false;
    });
  }

  void switchauthmode() {
    if (authMode == AuthMode.Login) {
      setState(() {
        authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        authMode = AuthMode.Login;
      });
    }
  }

  void signinwithphoneauthcredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _authService.fbauth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.pushNamed(context, HomePage.routeName);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final internetConn = Provider.of<Tool>(context).connectivity;
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(internetConn==ConnectivityResult.none){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('offline')));
      }
      else{
        print(internetConn);
      }
    });

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: Container(
        height: authMode == AuthMode.SignUp ? 320 : 260,
        constraints: BoxConstraints(
          minHeight: authMode == AuthMode.SignUp ? 320 : 260,
        ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.length != 10) {
                      return 'invalid phone number';
                    }
                  },
                  onSaved: (value) {
                    authData['phone'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty && value.length < 6) {
                      return 'password is too short';
                    }
                  },
                  controller: passcontroller,
                  onSaved: (value) {
                    authData['password'] = value!;
                  },
                ),
                if (authMode == AuthMode.SignUp)
                  TextFormField(
                    enabled: authMode == AuthMode.SignUp,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: authMode == AuthMode.SignUp
                        ? (value) {
                            if (passcontroller.text != value) {
                              return 'password mismatch';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (isloading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(authMode == AuthMode.SignUp ? 'SignUp' : 'Login'),
                    onPressed: submit,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ) ,
                    // padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                  ),
                TextButton(
                  onPressed: switchauthmode,
                  child: Text(
                      '${authMode == AuthMode.SignUp ? 'Login' : 'SignUp'} INSTEAD'),
                  //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                ElevatedButton(
                    onPressed: () {
                      _authService.signinwithgoogle();
                    },
                    child: Text("Sign in with Google")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _authService.fbauth.verifyPhoneNumber(
                        phoneNumber: '+91',
                        verificationCompleted: ((phoneAuthCredential) {}),
                        verificationFailed: (verificationFailed) async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(verificationFailed.message!)));
                        },
                        codeSent: ((verificationId, forceResendingToken) async {
                          setState(() {
                            this.verificationId = verificationId;
                          });
                        }),
                        codeAutoRetrievalTimeout: (verificationId) {},
                      );
                    },
                    child: Text("Sign in with phone")),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    controller: otpcontroller,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpcontroller.text);
                      signinwithphoneauthcredential(phoneAuthCredential);
                    },
                    child: Text('Verify otp'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _authService = AuthService.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: MediaQuery.of(context).size.height * 0.02),
            child: ElevatedButton(
                onPressed: () {
                  _authService.signinwithgoogle();
                },
                child: Text("Sign in with Google")),
          )
        ],
      ),
    );
  }
}
