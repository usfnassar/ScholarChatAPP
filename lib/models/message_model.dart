import 'package:scholar_chat/consts.dart';

class Message{
  String message;
  String id;
  Message( this.message,this.id);
  factory Message.fromJson(json)
  {
    return Message(json[KMessage],json[KId]);
  }
}