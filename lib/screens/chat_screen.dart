import 'package:chat_app_with_firebase/widgets/chats/messages.dart';
import 'package:chat_app_with_firebase/widgets/chats/new_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    Icon(Icons.logout,
                    color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
            onChanged: (v) {
              if (v == "logout") FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
