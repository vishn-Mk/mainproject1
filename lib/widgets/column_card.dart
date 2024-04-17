import 'package:flutter/material.dart';

class ColumnCardWidgets extends StatelessWidget {
  const ColumnCardWidgets({super.key, required this.text});

  final  String text;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(
          color: Colors.grey,
          thickness: .5,
        )
      ],
    );
  }
}
