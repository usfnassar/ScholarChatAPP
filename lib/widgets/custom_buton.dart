import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  String txt;
  VoidCallback? onTap;
   CustomButon({
    super.key,
     this.onTap,
    required this.txt,
    l
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              txt,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),

            ),
          ),
        ),
      ),
    );
  }
}
