 import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/consts.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/screens/login_screens.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
static String id='ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
CollectionReference messages = FirebaseFirestore.instance.collection(KMessagesCollection);

TextEditingController messageController=TextEditingController();
final controller=ScrollController();
@override
String? email;
  void getEmail()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email=prefs.getString('email');
    setState(() {

    });
  }
  @override
  void initState() {
getEmail();
checkIsBlocked();
super.initState();
  }

  Future<void> checkIsBlocked() async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signInWithEmailAndPassword(

          email:prefs.getString('email')!,
          password: "123",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(KisLogin, false);
        print( await prefs.getBool(KisLogin));
        Navigator.pushNamed(context, LoginScrens.id);
        MessageToUser(Message: 'You have been blocked', context: context,state: MessageState.ERROR);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async
          {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(KisLogin, false);
            print( await prefs.getBool(KisLogin));
            Navigator.pushNamed(context, LoginScrens.id);
          }, icon: Icon(Icons.logout,color: Colors.white,))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(KLogo,
              height: 50.0,
            ),
            Text('Chat'),
          ],
        ),

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt,descending: true).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData&&email!=null)
          {
            List<Message> messagesList=[];
            for(var message in snapshot.data!.docs )
              {
                messagesList.add(Message.fromJson(message));
              }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    controller: controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {

                      return messagesList[index].id==email?Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${email.toString()}   "),
                          Chatbubble(message: messagesList[index],),
                        ],
                      ):
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("   ${messagesList[index].id}"),
                      ChatbubbleFromFreind(message: messagesList[index]),
                        ],
                      );
                    },),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                  child: TextField(
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    minLines: 1,
                    onSubmitted: (value) {
                    },

                    decoration: InputDecoration(

                        hintText: "Message",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send,color: KPrimaryColor,),
                          onPressed: ()async{
                            checkIsBlocked();
                            setState(() {

                            });
                            controller.jumpTo(
                              0,
                            );

                            if (messageController.text == null || messageController.text.trim() == '') return;
                            messages.add({
                              KMessage:messageController.text,
                              KCreatedAt:DateTime.now(),
                              KId:email
                            });
                            messageController.clear();

                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)
                        )
                    ),
                  ),
                ),
              ],
            );
          }
          else
          {
            return Center(child: CircularProgressIndicator(
              color: KPrimaryColor,

            ));
          }
        },
      ),
    );
  }
}



