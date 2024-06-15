import 'package:flutter/material.dart';
const KPrimaryColor=Color(0xff2B475E);
const KSecondColor=Color(0xffc7ede6);
const KLogo='assets/images/scholar.png';
const KMessagesCollection='messages';
const KMessage='message';
const KCreatedAt='createdAt';
const KId='id';
const KisLogin='isLogin';
MessageToUser({required String Message,required context,MessageState?state})
{

  return   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(Message)),
    backgroundColor: ColorState(state),
    duration:Duration(seconds: 1),
  ));
}
enum MessageState {SUCCESS,ERROR,WARNING}
 Color? ColorState(MessageState? state)
 {
   Color? color;
   switch(state)
       {
     case MessageState.SUCCESS:
       color=Colors.green;
       break;
       case MessageState.ERROR:
       color=Colors.red;
       break;
       case MessageState.WARNING:
       color=Colors.amber;
       break;
       case null:
       color=Colors.black87;
       break;
   }
   return color;
 }
String? ValidatePassword(String? data) {
  if(data!.isEmpty)
  {
    return 'Can\'t be empty';
  }
  // else if(!validatePassword(data))
  //   {
  //     return 'The password provided is too weak.';
  //   }
  else if(!data.contains(RegExp(r'[A-Z]')))
  {
    return 'Password must have at least one uppercase character !!';
  }
  else if(!data.contains(RegExp(r'[a-z]')))
  {
    return 'Password must have at least one lowercase character !!';
  }
  else if(!data.contains(RegExp(r'[0-9]')))
  {
    return 'Password must have at least one digit character !!';
  }
  else if(!data.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
  {
    return 'Password must have at least one special character !!';
  }
  else if (data.length < 6) {
    return 'Password length must have at least 6 character !!';
  }
  else{
    return null;
  }
}
String? ValidateEmail(String? data) {

  if(data!.isEmpty)
  {
    return 'Can\'t be empty';
  }
  else if(!CheckEmail(data))
  {
    return "The email provided is wrong.";
  }
  else
  {
    return null;
  }
}
bool CheckEmail(String email) {

  String pattern = r'^.+@.+\..+$';

  RegExp regex = RegExp(pattern);

  return regex.hasMatch(email);

}
