import 'dart:convert';

import 'package:hive/hive.dart';
part 'todo_model.g.dart';
@HiveType(typeId: 1)
class todo {
  @HiveField(1)
  final String title;
   @HiveField(2)
  final String userid;
   @HiveField(3)
  final String body;
  
  
  
  

  todo(
      {required this.title,
      required this.userid,
      required this.body,
     
     });

  factory todo.fromJson(Map<String, dynamic> json) {
    return todo(
        title: json['title'] ?? '',
        userid: json['userid'] ?? '', 
          body:  json['body'] ??  '');
        
  
 
 
}
}