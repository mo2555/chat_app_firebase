import 'package:chat_app_with_firebase/widgets/chats/messagesView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").orderBy('sendAt',descending: true).snapshots(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        final docs = snapShot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) {
            var user = FirebaseAuth.instance.currentUser;
            return MessageView(
            docs[index]['username'],
            docs[index]['text'],
            user.uid==docs[index]['uId'],
              docs[index]['userImage'],
          );
          },
        );
      },
    );
  }
}
