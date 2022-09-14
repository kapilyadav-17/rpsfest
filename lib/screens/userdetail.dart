import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rpsfest/screens/tabs.dart';
class UserDetailPage extends StatefulWidget {
  //const UserDetailPage({Key? key}) : super(key: key);
  static const routeName = '/userDetail';
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  File? pickedImage;
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

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircleAvatar(
                    radius: 30,
                    backgroundImage: pickedImage != null
                        ? FileImage(pickedImage!)
                        : null,
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
    Navigator.of(context).pushNamed(Tabs.routeName);
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
