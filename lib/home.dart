import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Namelist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController date = TextEditingController();

  List<NameList> newList = [];

  void addData() async {
    final String surname = name.text;
    final double number = double.parse(age.text);
    final String about = condition.text;
    final double date1 = double.parse(date.text);

    var data = FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("about");

    var result = await data.add({
      "name": surname,
      "age": number,
      "condition": about,
      "date": date1
    }).then((value) {
      print(value);
      if (value != null) {
        Navigator.pushNamed(context, '/datapage');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 30, left: 30),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: age,
              decoration: const InputDecoration(hintText: 'Age'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              controller: date,
              decoration: const InputDecoration(hintText: 'Date'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              controller: condition,
              decoration: const InputDecoration(hintText: 'Condition'),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            margin: const EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  addData();
                });
              },
              style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
