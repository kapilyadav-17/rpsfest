import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rpsfest/screens/tabs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/auth.dart';
class UserDetailPage extends StatefulWidget {
  //const UserDetailPage({Key? key}) : super(key: key);
  static const routeName = '/userDetail';
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  static final AuthService _authService = AuthService.instance;
  static File? pickedImage;
  Future<void> pickImage() async {
    final ImagePicker imgpick = ImagePicker();

    XFile? imagepicker = await imgpick.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (imagepicker != null) {
      setState(() {
        pickedImage = File(imagepicker.path);
      });
    }
  }
  Future<void> pickImageGallery() async {
    final ImagePicker imgpick = ImagePicker();

    XFile? imagepicker = await imgpick.pickImage(
      source: ImageSource.gallery,

    );
    if (imagepicker != null) {
      setState(() {
        pickedImage = File(imagepicker.path);
      });
    }
  }
  static String? photoUrl;
  static Future<void> getPhotoUrl()async{
    if(pickedImage!=null){
      try {
        final ref = FirebaseStorage.instance.ref().child('profilePhoto').child(_authService.currentUser!.uid+'.jpeg');
        await ref.putFile(pickedImage!);
        photoUrl = await ref.getDownloadURL();
      } on Exception catch (e) {
        // TODO
        print(e.toString());
      }
    }
    else{
      print('no image chosen');
    }
  }
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircleAvatar(
                    radius: 70,
                    // backgroundImage: pickedImage != null
                    //     ? FileImage(pickedImage!)
                    //     : NetworkImage(_authService.currentUser!.photoURL.toString()),
                    child: pickedImage==null?Image.network(_authService.currentUser!.photoURL.toString(),fit: BoxFit.scaleDown,)
                    :Image.file(pickedImage!,fit: BoxFit.cover,),
                  ),SizedBox(width: 10,),
                  IconButton(onPressed: (){
                    showModalBottomSheet(context: context, builder: (BuildContext context){
                    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),),child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(leading: Icon(Icons.camera),title:Text('Take a Picture'),onTap: pickImage ,),
                          ListTile(leading: Icon(Icons.browse_gallery),title:Text('Choose from gallery'),onTap: pickImageGallery ,),
                        ],
                      ),);
                    },);
                  }, icon: Icon(Icons.edit,color: Colors.blueAccent,))],),
                  SizedBox(height: 10,),
                  UserDetail(),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthService _authService = AuthService.instance;
  Map<String,dynamic> authData ={
    'profilePhoto':'',
    'isAdmin':false,
    'registeredEvents':[],
    'name':'',
    'specialization':'',
    'email':'',
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
    await _UserDetailPageState.getPhotoUrl();
    if(_UserDetailPageState.photoUrl!=null){
      authData['profilePhoto']=_UserDetailPageState.photoUrl;
    }
    else{
      authData['profilePhoto']=_authService.currentUser!.photoURL;
    }
    await FirebaseFirestore.instance.collection('users').doc(_authService.currentUser!.uid).set(authData).then((value) {
      Navigator.of(context).pushNamed(Tabs.routeName);
      setState(() {
        isloading=false;
      });
    }).catchError((onError){
      print(onError.toString());
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

                  decoration: InputDecoration(labelText: 'name'),
                  //keyboardType: TextInputType.phone,
                  initialValue: _authService.currentUser!.displayName,
                  validator:
                      (value){if( value!.isEmpty){return 'enter name';}},
                  onSaved: (value){
                    authData['name']=value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  //keyboardType: TextInputType.a,
                  initialValue: _authService.currentUser!.email,
                  enabled: false,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Email';
                    }
                  },
                  onSaved: (value){
                    authData['email']=value!;
                  },

                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'course'),
                  keyboardType: TextInputType.text,

                  validator: (value){
                    if(value!.isEmpty ){
                      return 'Enter Course';
                    }
                  },

                  onSaved: (value){
                    authData['course']=value!;
                  },
                ),
                TextFormField(

                  decoration: InputDecoration(labelText: 'specialization'),

                  validator:
                      (value){if( value!.isEmpty){return 'enter specialization name';}},
                  onSaved: (value){
                    authData['specialization']=value!;
                  },
                ),

                SizedBox(height: 20,),
                if(isloading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child: Text('Continue'),
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
