import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);
  static String id = "chatPage";

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  String? data;
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Chat"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: messages.orderBy("time").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _controller,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return snapshot.data!.docs[index]["email"] == email
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(18),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                            bottomLeft: Radius.circular(18),
                                          )),
                                      child: Text(
                                          "${snapshot.data!.docs[index]["msg"]}"),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: EdgeInsets.all(18),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                            bottomLeft: Radius.circular(18),
                                          )),
                                      child: Text(
                                          "${snapshot.data!.docs[index]["msg"]}"),
                                    ),
                                  );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: controller,
                        onChanged: (value) {
                          data = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await messages.add({
                                    "msg": data,
                                    "time": DateTime.now(),
                                    "email": email
                                  });
                                  _controller.animateTo(
                                    _controller.position.maxScrollExtent,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                  controller.clear();
                                },
                                icon: Icon(Icons.send)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18))),
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
