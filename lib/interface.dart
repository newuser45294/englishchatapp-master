import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loveapp/users.dart';

import 'friends.dart';

class Interface extends StatefulWidget {
  String uid;
  Interface(this.uid);

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  var ref = FirebaseDatabase.instance.ref().child("Users");
  Future<void> addRoom(String uid, String name) async {
    var ref = FirebaseDatabase.instance.ref().child("Rooms");
    var map = HashMap<String, dynamic>();
    map["guess_uid"] = uid;
    map["yerel_uid"] = widget.uid;
    map["room_name"] = name;
    await ref.push().set(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("English Chat"),
        actions: [
          ElevatedButton(
              onPressed: () {}, child: Icon(Icons.access_alarms_sharp))
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
          stream: ref.onValue,
          builder: (context, event) {
            var usersList = [];
            if (event.hasData) {
              var veri = event.data!.snapshot.value as dynamic;
              veri.forEach((key, data) {
                var value = Users.fromJson(key, data);
                   usersList.add(value);
               
              });
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: usersList.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_box_outlined,
                            size: 200.0,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "${usersList[index].name}",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 90,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: (() {
                                  addRoom(usersList[index].uid,
                                      usersList[index].name);
                                }),
                                child: Text("Add Friend")),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
          }),
           drawer: Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("home"),
            onTap: () {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => Interface(widget.uid))
              );
            },
          ),
           ListTile(
            title: Text("friends"),
            onTap: () {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => Friends(widget.uid))
              );
            },
          )
        ],
      )
    ));
  }
}
