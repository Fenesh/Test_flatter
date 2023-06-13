import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_one.dart.';
import 'package:flutter_app/pages/main_two.dart.';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => OneMyapp(),
      '/two':(context) => TwoMyapp(),
    },
  ));
}



