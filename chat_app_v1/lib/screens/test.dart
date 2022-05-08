import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Column Example"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.red),
              child: Text(
                "React.js",
                style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.red),
              child: Text(
                "Flutter",
                style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.red),
              child: Text(
                "MySQL",
                style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
              ),
            )
          ]),
    );
  }
}
