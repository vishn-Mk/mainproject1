import 'package:flutter/material.dart';




 const baseUrl = 'https://vadakara-mca-turf-backend.onrender.com';

const indicator =  Center(
            child: CircularProgressIndicator(color: Colors.teal,),
          );


customSnackBar({
  required BuildContext context,
  required String  messsage,
}){

  return ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(messsage)));
}