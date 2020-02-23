import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/models/user.dart';
import 'package:login_firebase/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object on FirebaseUser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    //.map((FirebaseUser user)=> _userFromFirebaseUser(user));
  }

//reset password
  Future resetPassword(String email) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  //sign anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user; //Stream defined as user
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email
  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  //Register in with email
  Future registerWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).updateData('1', email, 200);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
