import 'dart:io';

import 'package:chat_app_with_firebase/widgets/Auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;

  submitFn(String email, String userNAme, String password, bool isLogin,File image,
      BuildContext ctx) async {
    UserCredential userCredential;
    try {
      setState(() {
        isLoading = true;
      });
      if (!isLogin) {
        userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var ref = FirebaseStorage.instance.ref().child('user_image').child(userCredential.user.uid);
        await ref.putFile(image);
        var imagePath = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
          'username': userNAme,
          'password': password,
          'image':imagePath,
        });
      }
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Error Occurred";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content:Text(errorMessage),
        backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Center(child: AuthForm(submitFn,isLoading)),
    );
  }
}
