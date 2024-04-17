import 'package:flutter/material.dart';

import '../../../widgets/column_card.dart';
import '../../../widgets/custom_button.dart';


class TurfDetailsWidget extends StatelessWidget {
   TurfDetailsWidget({super.key});

  final List<String> images = [
  
    'https://via.placeholder.com/400',
    'https://via.placeholder.com/500',
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Name',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
       bottomSheet: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          
          children: <Widget>[
            Expanded(
              child: CustomButton(
                text: 'Accept',
                onPressed: () => {},
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: CustomButton(
                text: 'Reject',
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
     
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/2.5,
                width:  MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://via.placeholder.com/150', // Replace with your image URL
                    
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                          ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                
                child: const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColumnCardWidgets(text: 'Type',),
                        Text('Football')
                                
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                
                child: const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColumnCardWidgets(text: 'Address',),
                        Text('Abc  Street , kerla,674555')
                                
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                
                child:  Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ColumnCardWidgets(text: 'Leagal Documents',),

                        
                          
                          SizedBox(
                            height: 300,
                            child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                  ),
                                  itemCount: images.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Image.network(images[index]),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Image.network(images[index], fit: BoxFit.cover),
                                    );
                                  },
                                ),
                          ),
                        
                                
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      )
    );
  }
}