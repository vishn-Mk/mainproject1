
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';


class AddPriceScreen extends StatelessWidget {
  const AddPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    final TextEditingController taxController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add price',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Category'),
            CustomTextField(
              hintText: 'Eg:football,cricket',
              controller: priceController,
            ),
            const SizedBox(height: 16.0),
            const Text('Time'),
            CustomTextField(
              hintText: 'Enter Time',
              controller: discountController,
            ),
            const SizedBox(height: 16.0),
            const Text('Charge'),
            CustomTextField(
              hintText: 'Enter charge',
              controller: taxController,
            ),

            CustomButton(
              text: 'Add', 
              onPressed: () {
              
            },)
          ],
        ),
      ),
    );
  }
}