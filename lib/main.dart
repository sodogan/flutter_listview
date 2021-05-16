import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/user.dart';
import './views/video_list.dart';

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
  void initState() {
    super.initState();
    _fetchData();
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
