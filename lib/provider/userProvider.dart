import 'package:flutter/material.dart';

import '../model/User.dart';

class UserProvider with ChangeNotifier{
  User loggedInUser = User(name: 'Kapil Yadav',course: "Btech",specialization: "Cse",email: "kapilyadav9127@gmail.com",profilePhoto: '',registeredEvents: null,isadmin: true);

  User get getloggedInUser => loggedInUser;
  //list of users for admin ??fb auth??==loggedin out
  void createUserAccount(User newUser){//only first time then sign in//TWO....ek fbAuth User and ek isme....handle??
    //api call to add new user in database
    //then initialiseUser
  }
  void initialseUser(User currentUser){
    //
  }
  void deleteUserAccount(User currentUser){

  }
  void updateProfile(User currentUser){//profilePhoto only

  }
  void addEvent(String eventId){

  }
  void removeEvent(String eventId){

  }
  void getRegisteredEvents(String currentUserEmailId){//return a list

  }
}