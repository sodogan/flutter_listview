import 'package:flutter/material.dart';
import '../model/user.dart';

class VideoCell extends StatelessWidget {
  final User user;

  VideoCell({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(user.picture.large),
          Text(
            user.fullName,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
    );
  }
}
