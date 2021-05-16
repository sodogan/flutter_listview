//{userId: 1, id: 1, title: quidem molestiae enim}
import 'package:flutter/material.dart';

class Name {
  final String title;
  final String first;
  final String last;

  Name({@required this.title, @required this.first,  @required this.last});
  factory Name.fromJSON(Map<String, dynamic> json) =>
      Name(title: json["title"], first: json["first"], last: json["last"]);

  String get fullName {
    return "$title $first $last";
  }

  @override
  String toString() {
    return "title :$title\t"
        "first :$first \t"
        "last :$last";
  }
}
/*
"picture": {
"large": "https://randomuser.me/api/portraits/women/47.jpg",
"medium": "https://randomuser.me/api/portraits/med/women/47.jpg",
"thumbnail": "https://randomuser.me/api/portraits/thumb/women/47.jpg"
}
*/

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({ @required this.large, @required this.medium, @required this.thumbnail});

  factory Picture.fromJSON(Map<String, dynamic> json) => Picture(
      large: json["large"],
      medium: json["medium"],
      thumbnail: json["thumbnail"]);

  @override
  String toString() {
    return "large :$large\t"
        "medium :$medium \t"
        "thumbnail :$thumbnail";
  }
}

class User {
  final String gender;
  final Name name;
  final String email;
  final Picture picture;

  User({@required this.gender, @required this.name, @required this.email, @required this.picture});

  factory User.fromJSON(Map<String, dynamic> json) => User(
      gender: json["gender"],
      name: Name.fromJSON(json["name"]),
      email: json["email"],
      picture: Picture.fromJSON(json["picture"]));

  String get fullName => name.fullName;

  @override
  String toString() {
    return "gender :$gender\t"
        "email :$email \t"
        "name :$name  \t"
        "picture :$picture";
  }
}
