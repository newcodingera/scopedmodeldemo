import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String id;
  final bool done;

  Todo({
    @required this.title,
    @required this.id,
    this.done = false
  });


  // A special constructor which
  // can be used to create a Todo object from the JSON data or Maps
  Todo.fromJson(Map<String, dynamic> json) 
              : title = json['title'],
                id = json['id'],
                done = false;

}