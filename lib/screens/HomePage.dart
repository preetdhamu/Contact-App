import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Add_Contact.dart';
import 'View_Contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  late int id;
  navigateToAddScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddContact();
    }));
  }

  navigateToViewScreen(id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return View_Contact(id:id);
    }));
  }

  //firebase animated list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          //firebase anmated List VIew
          child: FirebaseAnimatedList(
            query: _databaseReference,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              var value = Map<String, dynamic>.from(snapshot.value as Map);
              return GestureDetector(
                onTap: () {
                  navigateToViewScreen(snapshot.key);
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: value['photoUrl'] == null ||
                                    value['photoUrl'] == "empty"
                                ? DecorationImage(
                                    image: AssetImage("images/12.jpg"),
                                    fit: BoxFit
                                        .cover, // Adjust the fit based on your requirements
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                        value['photoUrl'].toString()),
                                    fit: BoxFit
                                        .cover, // Adjust the fit based on your requirements
                                  ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value['firstName'] == null
                                  ? ''
                                  : '${value['firstName']} ${value['lastName']}'),
                              Text(value['email'] == null
                                  ? ''
                                  : "${value['email']}"),
                              Text(value['phone'] == null
                                  ? ''
                                  : "${value['phone']}"),
                              Text(value['address'] == null
                                  ? ''
                                  : "${value['address']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddScreen,
          child: Icon(Icons.add),
        ));
  }
}
