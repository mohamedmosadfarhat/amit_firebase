import 'package:amit_firebase/chatpage.dart';
import 'package:amit_firebase/home_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static String id = "home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];

  getData() async {
    var item = await FirebaseFirestore.instance.collection("items").get();
    data.addAll(item.docs);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference items = FirebaseFirestore.instance.collection('items');
    Future<void> addItem() {
      return items
          .add({
            'image': "images/sparks.png", // John Doe
            'name': "Car 3", // Stokes and Sons
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("home page"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Chatpage.id);
              },
              icon: Icon(Icons.chat))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addItem();
            Navigator.of(context).pushNamed(HomePage.id);
          }),
      body: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () async {
                await FirebaseFirestore.instance
                    .collection("items")
                    .doc(data[index].id)
                    .delete();
                Navigator.of(context).pushNamed(HomePage.id);
              },
              onTap: () {
                Navigator.of(context).pushNamed(HomeDetails.id,
                    arguments: Args(image: data[index]["image"]));
              },
              child: Stack(
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                    child: Image.asset(
                      "${data[index]["image"]}",
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class Args {
  String image;
  Args({required this.image});
}
