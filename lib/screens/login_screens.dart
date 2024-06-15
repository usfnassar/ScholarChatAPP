import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/consts.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';
import 'package:scholar_chat/widgets/custom_buton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScrens extends StatefulWidget {
static String id='LoginScreen';

  @override
  State<LoginScrens> createState() => _LoginScrensState();
}

class _LoginScrensState extends State<LoginScrens> {
late String email;

String? password;

bool isLoading=false;

bool isPassword=true;

GlobalKey<FormState> formKey =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall:isLoading ,
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
                        Text('LOGIN',
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
                      validator: (value)
                      {
                        return ValidateEmail(value);
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
                      validator: (value)
                      {
                        return ValidatePassword(value);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    CustomButon(txt: 'Login',onTap: ()async{

                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {

                        isLoading=true;
                        setState(() {

                        });
                        try {
                                              await LoginUser();
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setBool(KisLogin, true);
                                              prefs.setString('email', email);
                                              Navigator.pushReplacementNamed(context, ChatScreen.id);

                        } on FirebaseAuthException catch (e) {
                                              MessageToUser(Message:e.code=='user-disabled'?'Your are blocked':'Wrong information check your Email and Password', context: context,state: MessageState.ERROR);

                                            }
                                            catch(e)
                                            {
                                              MessageToUser(Message: e.toString(), context: context);
                                            }
                                            isLoading=false;
                        setState(() {

                        });

                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          )
                          ),
                        SizedBox(height: 20.0,),
                        TextButton(onPressed: ()
                        {
                          Navigator.pushNamed(context, RegisterScrens.id);

                        },
                            child: Text('create account',
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

  Future<void> LoginUser() async {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password!,
    );
  }
}


