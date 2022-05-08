import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app_v1/screens/auth_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  double _value1 = 30;
  String _status1 = 'idle';
  Color _statusColor1 = Colors.amber;

  double _value2 = 300;
  String _status2 = 'idle';
  Color _statusColor2 = Colors.amber;

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AdminPanel'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AuthScreen()),
                      (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                Image.network(
                  "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/v1476701216/mirbd3cl82k7iphlfjxm.png",
                  width: 350,
                  height: 150,
                ),
                SizedBox(
                  //Use of SizedBox
                  height: 30,
                ),
                Text(
                  'Slide Below To change Temperature Values',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  //Use of SizedBox
                  height: 10,
                ),
                Slider(
                  min: 20,
                  max: 100,
                  value: _value1,
                  divisions: 20,
                  onChanged: (value) {
                    setState(() {
                      _value1 = value;
                      databaseRef.child("temp").set({
                        'temp': _value1.round(),
                      });
                      _status1 = 'active';
                      _statusColor1 = Colors.green;
                    });
                  },
                  onChangeStart: (value) {
                    setState(() {
                      _status1 = 'start';
                      _statusColor1 = Colors.lightGreen;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _status1 = 'end';
                      _statusColor1 = Colors.red;
                    });
                  },
                ),
                Text(
                  'Temperature : $_status1 : ${_value1.round()} ℃',
                  style: TextStyle(color: _statusColor1),
                ),
                SizedBox(
                  //Use of SizedBox
                  height: 50,
                ),
                Text(
                  'Slide Below To change Smoke Values',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  //Use of SizedBox
                  height: 10,
                ),
                Slider(
                  min: 200,
                  max: 10000,
                  value: _value2,
                  divisions: 98,
                  onChanged: (value) {
                    setState(() {
                      _value2 = value;
                      databaseRef.child("smoke").set({
                        'smoke': _value2.round(),
                      });
                      _status2 = 'active';
                      _statusColor2 = Colors.green;
                    });
                  },
                  onChangeStart: (value) {
                    setState(() {
                      _status2 = 'start';
                      _statusColor2 = Colors.lightGreen;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _status2 = 'end';
                      _statusColor2 = Colors.red;
                    });
                  },
                ),
                Text(
                  'Smoke : $_status2 : ${_value2.round()} ppm',
                  style: TextStyle(color: _statusColor2),
                ),
              ])),
        ));
  }
}
