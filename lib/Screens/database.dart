import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase/firebaseImpl.dart';

class Database extends StatefulWidget {
  Database({this.app});

  final FirebaseApp app;

  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Records'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return somethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            //List<String> itemList = readData();



            return Container(
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  print(snapshot.value["context"]);
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      // update
                      onTap: (){
                        _showDialog(snapshot.value["context"], snapshot.key);
                      },
                      trailing: IconButton(
                        //delete
                        onPressed: () =>
                            dbRef.child(snapshot.key).remove(),
                        icon: Icon(Icons.delete),
                        color: Colors.black,
                        highlightColor: Colors.red[500],
                      ),
                      title: Text(
                        "$index: ${snapshot.value["context"]}"
                        //"$index: ${snapshot.value.toString()}",
                      ),
                    ),
                  );
                },
                ),

            );

          }

          // Otherwise, show something whilst waiting for initialization to complete
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }


  _showDialog(String item, dynamic id) async{

    final itemText = new TextEditingController();
    //print(id);
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new TextField(
                controller: itemText,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Context update', hintText: item),
              ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Update'),
              onPressed: () {
                item = itemText.text;
                ///print(id); print(item);
                dbRef.child(id).update({'context': item});
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  List<String> readData(){
    List<String> items = [];
    dbRef.once().then((DataSnapshot snapshot) {
      if(snapshot.value != null){
        snapshot.value.forEach((key, value){
          String item = createItem(value);
          items.add(item);
        });
      }
      items.forEach((element) {print(element);});
      print('DataJSON : ${snapshot.value}');
    });

  }

  String createItem(record){
    Map<dynamic, String> attributes = {
      'context': ''
    };

    record.forEach((key, value) => {attributes[key] = value});

    String newItem = attributes['context'];
    return newItem;
    //print(newItem);
  }

  Widget somethingWentWrong() {
    return Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(image: AssetImage('assets/Error.png'))));
  }
}
