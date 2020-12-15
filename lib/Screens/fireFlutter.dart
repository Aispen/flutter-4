import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase/firebaseImpl.dart';

class FireFlutter extends StatefulWidget {
  @override
  _FireFlutterState createState() => _FireFlutterState();
}

class _FireFlutterState extends State<FireFlutter> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterFire'),
        centerTitle: true,
      ),

    );
  }

  Widget somethingWentWrong(){
    return Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
                image: AssetImage('assets/Error.png'))));
  }
}
