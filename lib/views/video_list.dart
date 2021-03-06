import 'package:flutter/material.dart';
import './video_cell.dart';
import '../model/user.dart';

class VideoList extends StatelessWidget {
  final userList;

  VideoList({@required this.userList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.userList != null ? this.userList.length : 0,
      itemBuilder: (context, i) {
        User currentUser = this.userList[i];
        final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        primary: Colors.white,
        minimumSize: Size(88, 44),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0),),
      ),
      backgroundColor: Colors.blue,
      );
        return Column(children: [
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              print("item pressed at index $i");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsView("Details Page");
              }));
            },
            child: VideoCell(
              user: currentUser,
            ),
          ),
          Container(
            height: 6.0,
          ),
          Divider(
            color: Colors.amber,
            height: 25.0,
          ),
        ]);
      },
    );
  }
}

class DetailsView extends StatelessWidget {
  final String _title;

  DetailsView(this._title);

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(children: [
      Text("Hello from the Details Page")

      ],),
    );
  }
}
