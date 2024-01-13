import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loveapp/friend.dart';
import 'package:loveapp/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interface.dart';

class Friends extends StatefulWidget {
  String y_uid;
  Friends(this.y_uid);
  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  var ref = FirebaseDatabase.instance.ref().child("Rooms");
  Future<void> saveUid(String key) async {
    var prefer = await SharedPreferences.getInstance();
    var get = prefer.getString("key") ?? key;
    setState(() {
      prefer.setString("key", get);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Interface"),
          actions: [
            ElevatedButton(
                onPressed: () {}, child: Icon(Icons.access_alarms_sharp))
          ],
        ),
        body: StreamBuilder<DatabaseEvent>(
            stream: ref.onValue,
            builder: (context, event) {
              var datalist = [];
              var keylist = [];
              if (event.hasData) {
                var value = event.data!.snapshot.value as dynamic;
                value.forEach((key, val) {
                  var data = Friend.fromJson(val);
                  if (data.yerel_uid == widget.y_uid || data.guess_uid == widget.y_uid) {
                    datalist.add(data);
                    keylist.add(key);
                  }
                });
              }
              return ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: ((context, index) {
                    return Row(
                      children: [
                        Text("${datalist[index].room_name}"),
                        SizedBox(height: 10),
                        ElevatedButton(
                          child: Text("Message"),
                          onPressed: (() {
                            saveUid(keylist[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Messages(datalist[index].room_name,"${keylist[index]}")));
                          }),
                        )
                      ],
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => Interface(widget.y_uid)));
              },
            ),
            ListTile(
              title: Text("friends"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Friends(widget.y_uid)));
              },
            )
          ],
        )));
  }
}
