import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/consts.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/login_screens.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool? disabled = await prefs.getBool(KisLogin);
  print(prefs.getBool(KisLogin));
  runApp( MyApp(disable: disabled,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.disable});
  bool? disable;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScrens.id:(context) => LoginScrens(),
        RegisterScrens.id:(context) => RegisterScrens(),
        ChatScreen.id:(context) => ChatScreen(),
      },
      initialRoute: disable==false||disable==null?'LoginScreen':ChatScreen.id,

    );
  }
}

