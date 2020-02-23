import 'package:flutter/material.dart';
import 'package:login_firebase/models/data.dart';
import 'package:login_firebase/screens/Home/my_list.dart';
import 'package:login_firebase/screens/Home/setting_form.dart';
import 'package:login_firebase/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:login_firebase/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  //bool loading = false;
  @override
  Widget build(BuildContext context) {
    void showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Data>>.value(
      value: DatabaseService().data,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          title: Text("Home"),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text("Settings"),
              onPressed: () => showSettingPanel(),
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () {
                _auth.signOut();
              },
            )
          ],
        ),
        body: Container(
           decoration: BoxDecoration(
             image: DecorationImage(
             image: AssetImage('assets/images/bg1.jpg'),
             fit: BoxFit.cover
             ),
           ),
          child: MyList(),
        ),
      ),
    );
  }
}
