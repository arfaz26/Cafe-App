import 'package:flutter/material.dart';
import 'package:login_firebase/models/user.dart';
import 'package:login_firebase/services/database.dart';
import 'package:login_firebase/shared/constant.dart';
import 'package:login_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update Your Settings",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) => val.isEmpty ? 'Enter a name' : null,
                      onChanged: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      decoration: textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          _currentSugars = val;
                        });
                      },
                    ),
                  ),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown,
                    label: '$_currentStrength',
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.brown[400],
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                            Navigator.pop(context);
                      }
                      // print(_currentName);
                      // print(_currentSugars);
                      // print(_currentStrength);
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
