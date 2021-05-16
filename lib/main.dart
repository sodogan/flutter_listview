import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './user.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RealWorldApp());
  }
}

class RealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RealWorldAppState("REAL WORLD APP");
}

class _RealWorldAppState extends State<RealWorldApp> {
  final String _title;
  var _isLoading = true;

  var _finalUserList;

  _RealWorldAppState(this._title);

  Future<List<dynamic>> _fetchData() async {
    final String apiURL = 'https://randomuser.me/api/?results=10';
    var parsedUserList;
    var randomUserList;
    //call the random API
    var response = await http.get(
      Uri.parse(apiURL),
    );
    if (response.statusCode == 200) {
      randomUserList = jsonDecode(response.body)["results"];
      parsedUserList = randomUserList
          .map((randomUser) => User.fromJSON(randomUser))
          .toList();
      print(parsedUserList.length);
    } else {
      throw new Exception("Failed to connect to the Random API");
    }

    //set the state here
    setState(() {
      _isLoading = false;
      this._finalUserList = parsedUserList;
    });
    return parsedUserList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this._title), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print("Before loading...");
            setState(() {
              _isLoading = true;
            });
            //fetch the data
            _fetchData();
          },
        ),
      ]),
      body: Center(
          child: _isLoading == true
              ? CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                )
              : VideoList(userList: _finalUserList)),
    );
  }
}

class VideoList extends StatelessWidget {
  final userList;

  VideoList({@required this.userList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.userList != null ? this.userList.length : 0,
      itemBuilder: (context, i) {
        User currentUser = this.userList[i];
        return Column(children: [
          VideoCell(user: currentUser,),
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

class VideoCell extends StatelessWidget {
  final User user;

  VideoCell({ @required this.user});
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
