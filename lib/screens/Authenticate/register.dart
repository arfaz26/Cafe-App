import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth.dart';
import 'package:login_firebase/shared/constant.dart';
import 'package:login_firebase/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[300],
              title: Text("Sign up"),
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Sign in"),
                  onPressed: () async {
                    await widget.toggleView();
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email);
                            if (emailValid == false) {
                              return 'invalid Email';
                            } else {
                              return null;
                            }
                          },
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Email', hintText: 'username')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) {
                          if (val.trim().length < 6) {
                            return 'password less than 6';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Password', hintText: 'Password'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                          child: Text("Register"),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              try {
                                dynamic result = await _auth.registerWithEmail(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'error in sign up';
                                  });
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            }
                          }),
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          );
  }
}
