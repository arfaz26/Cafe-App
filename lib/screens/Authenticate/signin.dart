import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth.dart';
import 'package:login_firebase/shared/constant.dart';
import 'package:login_firebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String resEmail = '';
  String password = '';
  String error = '';
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  final _form1key = GlobalKey<FormState>();
  //TextEditingController _email = TextEditingController();
  //TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[300],
              title: Text("Sign in"),
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person_add),
                  label: Text("Signup"),
                  onPressed: () async {
                    await widget.toggleView();
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                        //  controller: _email,
                        onChanged: (val) {
                          setState(() {
                            email = val.trim();
                          });
                        },
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Email', hintText: 'Username'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val.trim().length < 6) {
                            return 'Enter Password greater than 6';
                          } else {
                            return null;
                          }
                        },
                        // controller: _password,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Password', hintText: 'Password'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Sign in"),
                        onPressed: () async {
                          //await _auth.signInAnon();
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.signInWithEmail(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'wrong email or password';
                              });
                            }
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      child: Text("Forgot password?"),
                      onTap: () {
                        // print("object");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return customDialog();
                            });
                      },
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          );
  }

  Widget customDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 170.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Form(
            key: _form1key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(resEmail);
                    if (emailValid == false) {
                      return 'invalid Email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      resEmail = val.trim();
                    });
                  },
                  decoration: textInputDecoration.copyWith(
                      labelText: 'Email', hintText: 'abcd@gmail.com'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text("Get Link"),
                    onPressed: () async {
                      if (_form1key.currentState.validate()) {
                        await _auth.resetPassword(resEmail);
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
