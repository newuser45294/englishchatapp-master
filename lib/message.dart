import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loveapp/messjso.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Messages extends StatefulWidget {
  String room_name;
  String key_n;
  Messages(this.room_name, this.key_n);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {


  Future<void> setMessage(String message) async {
    var ref =
        FirebaseDatabase.instance.ref().child("Rooms/${widget.key_n}/Message");
    var map = HashMap();

    map["message"] = message;
    await ref.push().set(map);
  }
 Future<void> denemeMessage() async {
    var ref =
        FirebaseDatabase.instance.ref().child("Rooms/${widget.key_n}/Message");
    var map = HashMap();
    map["message"] = "deneme";
    await ref.push().set(map);
  }
  @override
  void initState() {
  
    print("${widget.key_n}");
   denemeMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ref =
        FirebaseDatabase.instance.ref().child("Rooms/${widget.key_n}/Message");
    var name = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.key_n),
        ),
        body: StreamBuilder<DatabaseEvent>(
            stream: ref.onValue,
            builder: (context, event) {
              var list = [];
              if (event.hasData) {
                var data = event.data!.snapshot.value as dynamic;
                if(data != null){
                  data.forEach((key, data) {
                  var veri = Messager.fromJson(data);
                  list.add(veri);
                });
                }
                   
              
               
              }
              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                        
                            Card(
                              color: Colors.blue,
                              child: SizedBox(
                                height: 70,
                                width: 300,
                                child: Center(
                                    child: Text(
                                  "${list[index].message}",
                                  style: TextStyle(fontSize: 30),
                                )),
                              ),
                            ),
                          ],
                        );
                      })),
                      Align(
                        alignment : Alignment.bottomLeft,
                        child : TextField(
                          controller: name,
                          decoration: InputDecoration(
                            hintText: "Mesaj Yaz"
                          ),)
                      ),
                    Align(
                        alignment : Alignment.bottomRight,
                        child : ElevatedButton(
                          child: Text("Send"),
                          onPressed: () {
                            setMessage(name.text);
                          }),

                        )
                ],
              );
            }));
  }
}
