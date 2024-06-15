import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  IconData prefixIcon;
  String lapel;
  Function(String)? onChange;
  String? Function(String?)? validator;
  FocusNode myFocusNode = new FocusNode();
  bool? isPassword=false;
  Widget? sufIcon;

  CustomTextField({required this.prefixIcon,required this.lapel,this.onChange, this.validator,this.isPassword,this.sufIcon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      obscureText:isPassword??false,

      validator: validator,
      onChanged:onChange,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: lapel,
        suffixIcon: sufIcon,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused)?Colors.blue:
            Colors.white,

        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
        ),
      ),
    );
  }
}



  bool _validateEmail(String email) {

    String pattern = r'^.+@.+\..+$';

    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);

  }

