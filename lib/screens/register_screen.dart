import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/consts.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';
import 'package:scholar_chat/widgets/custom_buton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScrens extends StatefulWidget {
static String id='RegisterScreen';

  @override
  State<RegisterScrens> createState() => _RegisterScrensState();
}

class _RegisterScrensState extends State<RegisterScrens> {
late String email;

String? password;

bool isLoading=false;
bool isPassword=true;

GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        color: KSecondColor,
      ),
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0,),

                    Image.asset('assets/images/scholar.png'),
                    Text('Scholar Chat',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Row(
                      children: [
                        Text('REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0,),

                    CustomTextField(prefixIcon: Icons.email,lapel: "Email",
                    onChange: (value)
                      {
                        email=value;
                      },
                      validator: (data)
                      {
                         return ValidateEmail(data);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    CustomTextField(prefixIcon: Icons.lock,lapel: "Password",
                    sufIcon: IconButton(
                      onPressed: (){
                        isPassword=isPassword?false:true;
                        setState(() {

                        });
                      },
                      icon: Icon(
                          isPassword?Icons.visibility:Icons.visibility_off
                      ),
                      color: Colors.white,
                    ),

                    isPassword: isPassword,
                    onChange: (value)
                      {
                        password=value;
                      },
                      validator: (data)
                      {
                         return ValidatePassword(data);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    CustomButon(txt: 'Register',onTap: ()async{
                      FocusManager.instance.primaryFocus?.unfocus();
                      FirebaseAuth auth = FirebaseAuth.instance;
                      if (formKey.currentState!.validate()) {
                        try {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool(KisLogin, true);
                          prefs.setString('email', email);
                          isLoading=true;
                          setState(() {

                          });
                                              await RegisterUser(auth);
                                              MessageToUser(Message: 'Account Created Successfully',context: context, state: MessageState.SUCCESS);
                                              Navigator.pushNamed(context, ChatScreen.id);


                        }
                                            on FirebaseAuthException catch (e) {
                                              if (e.code == 'weak-password') {
                                                MessageToUser(Message: 'The password provided is too weak.',context: context, state: MessageState.ERROR);
                                              } else if (e.code == 'email-already-in-use') {
                                                MessageToUser(Message: 'The account already exists for that email.',context: context, state: MessageState.ERROR,);
                                              }
                                            }
                                            catch(e)
                                            {
                                              MessageToUser(Message: e.toString(),context: context, state: MessageState.ERROR,);
                                            }
                                            isLoading=false;
                        setState(() {

                        });
                      }
                      else{

                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(
                              color: Colors.white,
                            )
                        ),
                        SizedBox(height: 20.0,),

                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        },
                          child: Text('Login',
                            style: TextStyle(
                              color: KSecondColor,
                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> RegisterUser(FirebaseAuth auth) async {
     UserCredential user= await auth.createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                     );
  }
}



