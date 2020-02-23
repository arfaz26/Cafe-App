import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_firebase/models/data.dart';
import 'package:login_firebase/models/user.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid});
  final CollectionReference myCollection =
      Firestore.instance.collection('My Data');

  Future updateData(String sugars, String name, int strength) async {
    return await myCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Data> _dataList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Data(
        name: doc.data['name'] ?? ' ',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Data>> get data {
    return myCollection.snapshots().map(_dataList);
  }

//user data from snapshot

  UserData _userDataFromSnaphot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

//get user doc stream

  Stream<UserData> get userData {
    return myCollection.document(uid).snapshots().map(_userDataFromSnaphot);
  }
}
