import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Contact());
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                height: 100.0,
                width: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/school.jpg'),
                  ),
                ),
              ),
              Card(
                elevation: 5.0,
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Reason to contact',
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5.0,
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  maxLength: 200,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Query...',
                    counterText: '200',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 20, right: 10),
                width: double.infinity,
                height: 45.0,
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.deepOrange[700],
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
