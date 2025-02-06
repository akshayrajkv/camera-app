import 'dart:io';

import 'package:flutter/material.dart';

class Photoscreen extends StatelessWidget {
  final File image;
  
  
  const Photoscreen({super.key,required this.image,});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Photo',style: TextStyle(fontSize: 28),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            delete(context);
          }, icon:const Icon(Icons.delete,color: Colors.red,))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.file(image),
      ),
    );
  }
  Future<void>delete(BuildContext context)async{
      image.delete();
      Navigator.pop(context);

  }
  
}