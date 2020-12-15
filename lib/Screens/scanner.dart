import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase/firebaseImpl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  FireDb database = new FireDb();
  String qrScanResult = 'Not Scanned Yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
        centerTitle: true,
      ),
      body: baseScreen(),
    );
  }

  Widget baseScreen() {
    return Container(
      padding: EdgeInsets.all(80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('RESULT',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Divider(height: 10.0, color: Colors.transparent,),
          Text(qrScanResult,
            style: TextStyle(fontSize: 17.0),
            textAlign: TextAlign.center,
          ),
          Divider(height: 50.0, color: Colors.transparent,),
          scanButton('Scan QR Code'),
          Divider(height: 15.0, color: Colors.transparent,),
          saveButton('Save Scanned Text')
        ],
      ),
    );
  }

  Widget scanButton(String text) {
    return FlatButton(
      child: Text(text),
      onPressed: () async {
        String scannedQr = await BarcodeScanner.scan();
        setState(() {
          qrScanResult = scannedQr;
        });
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.cyan, width: 3.0)
      ),
    );
  }

  Widget saveButton(String text){
    return FlatButton(
      child: Text(text),
      onPressed: () async {
        itemSave();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.cyan, width: 3.0)
      ),
    );
  }

  void itemSave(){
    if(qrScanResult == "Not Scanned Yet"){
      Fluttertoast.showToast(
          msg: 'Scan QR Code First',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
    }
    else{
      database.addItem(qrScanResult);
      Fluttertoast.showToast(
          msg: 'QR Is Saved In Firebase',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
    }
  }
}