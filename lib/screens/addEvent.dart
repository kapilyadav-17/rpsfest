import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rpsfest/provider/eventProvider.dart';
import 'package:uuid/uuid.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);
  static const routeName = '/addEvent';
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var uuid = Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  File? pickedImage;
  bool isloading = false;
  Map<String,dynamic> eventData={
    'eventId':'',
    'eventName':'',
    'eventImage':'',
    'description':'',
    'participantsIds':['kapilyadav9128@gmail.com'],
  };


  Future<void> pickImageGallery() async {
    final ImagePicker imgpick = ImagePicker();

    try {
      XFile? imagepicker = await imgpick.pickImage(
        source: ImageSource.gallery,

      );
      if (imagepicker != null) {
        setState(() {
          pickedImage = File(imagepicker.path);
        });
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }
  void submit()async{
    if(!_formKey.currentState!.validate()){
      return ;
    }
    _formKey.currentState!.save();
    if(pickedImage==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please upload an image for event')));
      return ;
    }
    setState(() {
      isloading=true;
    });
    try {
      var eventId = uuid.v4();
      eventData['eventId']=eventId;
      final ref = FirebaseStorage.instance.ref().child('eventImages').child(eventId+'.jpeg');

      await ref.putFile(pickedImage!);
      eventData['eventImage'] = await ref.getDownloadURL();

    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    //how to implement if no error in storing then rest of code should be started
    Provider.of<EventProvider>(context,listen: false).addEvent(eventData).then((value){
      setState(() {
        isloading= false;

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event added successfully')));
      Navigator.of(context).pop();
    }).catchError((onError){
      setState(() {
        isloading= false;

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('could not be added')));
      print(onError.toString());
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Enter Event Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                  child: TextFormField(
                    controller: eventNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter event name'

                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter event name';
                      }
                    },
                    onSaved: (value){
                      eventData['eventName']=value!;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                  height: 100,
                  child: TextFormField(
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    controller: eventDescriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter event Description',
                      //helperMaxLines: 10
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter event description';
                      }
                    },
                    onSaved: (value){
                      eventData['description']=value!;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: pickImageGallery, child: Text('Pick Event Image')),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: pickedImage==null?Text('select image'):
                            Image.file(pickedImage!,fit: BoxFit.fill,)
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                isloading?CircularProgressIndicator():ElevatedButton(onPressed: submit, child: Text('Save Changes')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
