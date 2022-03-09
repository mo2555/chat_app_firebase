import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  final String user;
  final String message;
  final bool isMe;
  final String userImage;

  MessageView(this.user, this.message, this.isMe, this.userImage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: isMe?Alignment.centerRight:Alignment.centerLeft,
          padding: EdgeInsets.only(
            right: isMe?5:0,
            left: !isMe?5:0,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            radius: 15,
            backgroundColor: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              width: MediaQuery.of(context).size.width *
                  (message.length > 150 ? 0.6 : 0.4),
              decoration: BoxDecoration(
                  color: isMe ? Colors.pink[400] : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: isMe ? Radius.circular(8) : Radius.circular(0),
                    bottomRight:
                        !isMe ? Radius.circular(8) : Radius.circular(0),
                  )),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: isMe ? 25 : 10,
                right: !isMe ? 25 : 10,
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "$user",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.black),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    "$message",
                    style: TextStyle(color: isMe ? Colors.black : Colors.black),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    maxLines: 100,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
