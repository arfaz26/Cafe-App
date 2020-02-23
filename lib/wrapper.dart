import 'package:flutter/material.dart';
import 'package:login_firebase/models/user.dart';
import 'package:login_firebase/screens/Authenticate/authenticate.dart';
import 'package:login_firebase/screens/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 

    //stream change 
    final user =Provider.of<User>(context);
    print(user);
    
    //home or authenticate screen
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}