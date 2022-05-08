import 'package:chat_app_v1/models/user_model.dart';
import 'package:chat_app_v1/screens/auth_screen.dart';
import 'package:chat_app_v1/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(this.user);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dref_temp = FirebaseDatabase.instance.ref().child('temp');
  final dref_smoke = FirebaseDatabase.instance.ref().child('smoke');
  final FlutterTts flutterTts = FlutterTts();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Future _speak_temp_U() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      print(await flutterTts.getVoices);
      await flutterTts.speak("Temperature Under Control");
    }

    Future _speak_smoke_U() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      print(await flutterTts.getVoices);
      await flutterTts.speak("Smoke Under Control");
    }

    Future _speak_temp_W() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      print(await flutterTts.getVoices);
      await flutterTts.speak("Temperature in warning range!");
    }

    Future _speak_smoke_W() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      print(await flutterTts.getVoices);
      await flutterTts.speak("Smoke in warning range!");
    }

    Future _speak_temp_C() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      print(await flutterTts.getVoices);
      await flutterTts.speak("Temperature in critical range!");
    }

    Future _speak_smoke_C() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      print(await flutterTts.getVoices);
      await flutterTts.speak("Smoke in critical range!");
    }

    print(user?.displayName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.displayName.toString()}'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(
                "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/v1476701216/mirbd3cl82k7iphlfjxm.png",
                width: 350,
                height: 150,
              ),
              Text(
                "Temperature Alarm",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                margin: const EdgeInsets.all(40.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.teal),
                child: SafeArea(
                  child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: dref_temp,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      var _temp =
                          int.parse(snapshot.child('temp').value.toString());
                      print("${_temp} : ${_temp.runtimeType} ");

                      if (_temp >= 70) {
                        _speak_temp_C();
                        print("True");
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                          child: Text(
                            'Temperature : ${snapshot.child('temp').value.toString()} ℃\n\n 1. Immediately evacuate the building to the outside.\n 2. NEVER go back to retrieve personal belongings.\n 3. Move away from the front of the building to allow the fire fighters and their trucks to access the building.\n  4. If there is an incident on the upper floors, the area underneath is the hazard zone and that is where you will be injured by falling glass and debris.',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      } else if (_temp >= 58 && _temp <= 70) {
                        _speak_temp_W();
                        print("True");
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orange),
                          child: Text(
                            'Temperature : ${snapshot.child('temp').value.toString()} ℃\n\n Warning!\n\n Warning!\n',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }
                      _speak_temp_U();
                      return Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green),
                        child: Text(
                          'Temperature : ${snapshot.child('temp').value.toString()} ℃\n\n Temperature Under Control!\n',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(
                "Smoke Alarm",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                margin: const EdgeInsets.all(40.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.teal),
                child: SafeArea(
                  child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: dref_smoke,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      var _smoke =
                          int.parse(snapshot.child('smoke').value.toString());
                      print("${_smoke} : ${_smoke.runtimeType} ");

                      if (_smoke >= 6000) {
                        _speak_smoke_C();
                        print("True");
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                          child: Text(
                            'Smoke : ${snapshot.child('smoke').value.toString()} ppm\n\n 1. Crawl if there is smoke: If you get caught in smoke, get down and crawl, taking short breaths through your nose.\n 2. Feel the doors before opening: Before opening any doors, feel the door knob or handle. If it’s hot, don’t open the door.\n 3. Move away from the front of the building to allow the fire fighters and their trucks to access the building.\n  4. Go to the nearest exit or stairwell: If the nearest exit is blocked by fire, heat, or smoke, go to another exit.',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      } else if (_smoke >= 3000 && _smoke < 6000) {
                        _speak_smoke_W();
                        print("True");
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orange),
                          child: Text(
                            'Smoke : ${snapshot.child('smoke').value.toString()} ppm\n\n Warning!\n\n Warning!\n',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }
                      _speak_smoke_U();
                      return Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green),
                        child: Text(
                          'Smoke : ${snapshot.child('smoke').value.toString()} ppm\n\n Smoke Under Control!\n',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                //Use of SizedBox
                height: 20,
              ),
            ]),
      ),
    );
  }
}
