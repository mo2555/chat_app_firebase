
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  final Function(File imageFile) imageFn;

  const PickImage(this.imageFn);
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
ImagePicker _pickImage = ImagePicker();
File image;
  getImage(ImageSource src)async{
  final pick = await _pickImage.pickImage(source: src,imageQuality: 30,maxWidth: 150);
  if(pick!=null)
  setState(() {
    image = File(pick.path);
  });
  widget.imageFn(image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: image==null?null:FileImage(image),
        ),
        SizedBox(
          height: 10,
        ),
        LayoutBuilder(
          builder: (ctx,con)=> Container(
            width: con.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton.icon(
                      onPressed: () {
                         getImage(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera_alt_outlined),
                      label: Text("Select image\nFrom camera"),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image_outlined),
                      label: Text("Select image\nFrom gallery"),
                    ),
                  ],
                ),
            ),
        ),

      ],
    );
  }
}
