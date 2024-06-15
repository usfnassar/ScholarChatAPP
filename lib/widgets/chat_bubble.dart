import 'package:flutter/material.dart';
import 'package:scholar_chat/consts.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:flutter/services.dart';

class Chatbubble extends StatelessWidget {
   Chatbubble({
    required this.message
  });
Message message;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: message.message));
        MessageToUser(Message: 'Text Copied',context: context);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
          padding: EdgeInsets.all(16.0),

          decoration:BoxDecoration(
            color: Color(0xff006389),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),

          ),
          child: Text(message.message,style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}

class ChatbubbleFromFreind extends StatelessWidget {
   ChatbubbleFromFreind({
    required this.message
  });
Message message;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: message.message));
        MessageToUser(Message: 'Text Copied',context: context);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
          padding: EdgeInsets.all(16.0),

          decoration:BoxDecoration(
            color: KPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),

          ),
          child: Text(message.message,style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}