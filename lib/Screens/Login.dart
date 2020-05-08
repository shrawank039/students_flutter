import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset("Images/school.jpg"),
                width: 150,
                height: 150,
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Registration ID',
                    ),
                  ),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: RaisedButton(
                    elevation: 5,
                    textColor: Colors.white,
                    child: Text("Login"),
                    color: Colors.lightBlue[900],
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      /*Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => landPage()));*/
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
