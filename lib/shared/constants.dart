import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/authenticate/register.dart';

const textInputDecoration = InputDecoration(
fillColor: Colors.white,
filled: true,
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.pink,
width: 2.0,)));

class registerVariables {

  final String? name;
  final String? username;

  registerVariables({this.username, this.name});

}