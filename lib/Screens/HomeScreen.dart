import 'package:flutter/material.dart';
import 'package:flutter3/Screens/scanner.dart';
import 'package:flutter3/Screens/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter QR'),
          centerTitle: true,
        ),
        body: baseScreen()
    );
  }

  Widget baseScreen() {
    return Container(
      padding: EdgeInsets.all(80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          image(),
          Divider(height: 50,color: Colors.transparent,),
          flatButton("Scan QR Code", Scanner()),
          Divider(height: 15,color: Colors.transparent,),
          flatButton("FlutterFire", Database())
        ],
      ),
    );
  }

  Widget image(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image(image: NetworkImage(
          "https://cdn0.iconfinder.com/data/icons/material-style/48/qrcode-512.png")),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      child: Text(text),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> widget));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.cyan, width:  3.0)
      ),
    );
  }
}
