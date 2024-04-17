
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color ? color;
  final Color ? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color?? Colors.teal, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))// Button color
      ),
      child:  Text(text,style:  TextStyle(color:textColor ?? Colors.white),),
    );
  }
}