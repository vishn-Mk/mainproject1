import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;

   const CardWidget({super.key, required this.iconData, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Card(
        
        elevation: 2.0,
        color: Colors.teal,
        shape: RoundedRectangleBorder(
          
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40.0,
                color: Colors.white,
              ),
              const  SizedBox(height: 15.0),
              Text(
                title,
                style:  const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
