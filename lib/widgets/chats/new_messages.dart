import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {

  TextEditingController messageController = TextEditingController();
  String message = "";

  sendMessage() async{
    FocusScope.of(context).unfocus();
    var user = FirebaseAuth.instance.currentUser;
    var username = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection("chat").add({
      'text': message,
      'sendAt': Timestamp.now(),
      'username':username['username'],
      'uId': user.uid,
      'userImage':username['image'],
    });
    messageController.clear();
    setState(() {
      message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(hintText: "Send a message..."),
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: message == "" ? null : sendMessage,
          ),
        ],
      ),
    );
  }
}
