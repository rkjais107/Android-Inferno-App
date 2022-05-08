import 'package:chat_app_v1/models/user_model.dart';
import 'package:chat_app_v1/realtime_db/insert.dart';
import 'package:chat_app_v1/screens/Admin_Panel.dart';
import 'package:chat_app_v1/screens/auth_screen.dart';
import 'package:chat_app_v1/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rename/rename.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Future<Widget> userSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (user?.uid == 'UquqEnbicrNVyNirghuWGNES8md2') {
        return AdminPanel();
      } else {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        UserModel userModel = UserModel.fromJson(userData);

        return HomeScreen(userModel);
        //return RealtimeDatabaseInsert();
      }
    } else {
      return AuthScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: userSignedIn(),
            builder: (context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }
}
