import 'dart:io';

import 'package:chat_app_with_firebase/widgets/Auth/pickImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String userNAme, String password, bool isLogin,File image,
      BuildContext ctx) submitFn;
  final bool isLoading;

  const AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String emailAddress = '';

  String password = '';

  String userName = '';

  var formKey = GlobalKey<FormState>();

  bool isLogin = true;
  File image;

  imageFn(File imageFile) {
    setState(() {
      image = imageFile;
    });
  }

  submit() {
    var isValid = formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (image == null && !isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) formKey.currentState.save();
    widget.submitFn(
        emailAddress.trim(), userName.trim(), password, isLogin,image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (!isLogin) PickImage(imageFn),
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail Address",
                  ),
                  validator: (val) {
                    if (val.isEmpty || !val.contains("@"))
                      return "Please enter a valid email";
                    return null;
                  },
                  onSaved: (val) {
                    emailAddress = val;
                  },
                ),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey('userName'),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    validator: (val) {
                      if (val.isEmpty || val.length < 4)
                        return "Please enter a valid username";
                      return null;
                    },
                    onSaved: (val) {
                      userName = val;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (val) {
                    if (val.isEmpty || val.length < 7)
                      return "Please enter a valid password";
                    return null;
                  },
                  onSaved: (val) {
                    password = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: submit,
                    child: Text(isLogin ? "Login" : "Sign up"),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? "Create new account"
                        : "I already have an account"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
