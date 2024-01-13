import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loveapp/interface.dart';



class FormName extends StatefulWidget {
  String uid;
  bool girisMi;
  FormName(this.uid, this.girisMi);

  @override
  State<FormName> createState() => _FormNameState();
}

class _FormNameState extends State<FormName> {
  Future<void> AddUserKnow(String name) async {
    var ref = FirebaseDatabase.instance.ref().child("Users");
    var map = HashMap<String, String>();
    map["uid"] = widget.uid;
    map["name"] = name;
    if (widget.girisMi) {
      print("Kayda İhtiyaç Yok");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Interface(widget.uid)));
    } else {

      ref.push().set(map);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Interface(widget.uid)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: name,
          decoration: InputDecoration(hintText: "Name"),
        ),
        ElevatedButton(
            onPressed: (() {
              print("press");
              AddUserKnow(name.text);
            }),
            child: Text("Devam"))
      ],
    ));
  }
}
