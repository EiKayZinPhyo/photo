import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Namelist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Data extends StatefulWidget {
  List<NameList> newList = [];

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data'),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homepage');
              },
              icon: Icon(Icons.arrow_back)),
        ),
        // body:Container(child:Text('Hello')));
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("test")
              .doc(FirebaseAuth.instance.currentUser?.uid.toString())
              .collection("about")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.hasError);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: Text(snapshot.data!.docs[index]['name']),
                    );
                  }));
            } else {
              return Container();
            }
          },
        ));
  }
}
