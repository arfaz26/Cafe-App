import 'package:flutter/material.dart';
import 'package:login_firebase/models/data.dart';

class DataTile extends StatelessWidget {

final Data data;
DataTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: Card(
        color: Colors.white60,
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
        child: ListTile(
          
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[data.strength],
          ),
          title: Text(data.name),
          subtitle: Text(data.sugars),
        ),
      ),
    );
  }
}