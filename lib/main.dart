import 'package:flutter/material.dart';
import 'package:login_firebase/models/user.dart';
import 'package:login_firebase/services/auth.dart';
import 'package:login_firebase/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Firebase App',
        home: Wrapper(),
      ),
    );
    
  }
}
