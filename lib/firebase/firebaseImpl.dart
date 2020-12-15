import 'package:firebase_database/firebase_database.dart';

class FireDb{
  final database = FirebaseDatabase.instance.reference();

  DatabaseReference addItem(String item){
    database.child('items').push().set({'context': item});
  }

  void updateItem(String item, String id){
    database.child('items').child(id).update({'context': item});
  }

  void deleteItem(String id){
    database.child('items').child(id).remove();
  }

  getAllItems() {
    DatabaseReference snapshot = database.reference().child('items/');
    return snapshot;
    /*List item = [];
    if(snapshot.value != null){
      List _item = [];
      _item= snapshot.value;
      _item.forEach((element) {
        if(element!=null){
          item.add(element);
        }
      });
    }
    return item;*/
  }
}


