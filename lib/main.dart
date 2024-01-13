

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loveapp/firebase_options.dart';
import 'package:loveapp/form.dart';
import 'package:loveapp/friends.dart';
import 'package:loveapp/interface.dart';
import 'package:loveapp/message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var te1 = TextEditingController();
  var te2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> register(String email, String password) async {
      try {
        final oturum = FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormName(value.user!.uid, false)));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    Future<void> SignIn(String email, String password) async {
      try {
        final oturum = FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Interface(value.user!.uid)));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: Center(
          child: Container(
        width: 300,
        height: 300,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: te1,
                  decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 10, color: Colors.white))),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: te2,
                  decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 10, color: Colors.white))),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (() {
                      SignIn(te1.text, te2.text);
                    }),
                    child: Text("Sıgn In"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (() {
                      register(te1.text, te2.text);
                    }),
                    child: Text("Register"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
