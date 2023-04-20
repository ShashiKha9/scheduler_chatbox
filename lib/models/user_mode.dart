import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel{
  late String uId,name,image,phoneNo,typing,status,online;
  UserModel({
    required this.name,
    required this.image,
    required this.online,
    required this.phoneNo,
    required this.status,
    required this.typing,
    required this.uId,
});

  factory UserModel.fromJson(Map<String,dynamic> json)=>UserModel(
      name: json["name"],
      image: json["image"],
      online: json["online"],
      phoneNo: json["phoneNo"],
      status: json["status"],
      typing: json["typing"],
      uId: json["uId"]


  );
  Map<String,dynamic> toJson()=>{
    "uId":uId,
    "name":name,
    "phoneNo":phoneNo,
    "status":status,
    "typing":typing ,
    "online":online,
    "image":image,



  };
}