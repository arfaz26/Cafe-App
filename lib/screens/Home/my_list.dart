import 'package:flutter/material.dart';
import 'package:login_firebase/screens/Home/data_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:login_firebase/models/data.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    final datas = Provider.of<List<Data>>(context) ?? [];
  return ListView.builder(
    itemCount: datas.length,
    itemBuilder: (BuildContext context, int index){
      return DataTile(data: datas[index]);
    },
  );

}
}