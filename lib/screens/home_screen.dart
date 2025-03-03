import 'package:camera_app2/screens/camera_preview_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
  backgroundColor:  Color.fromARGB(255, 238, 205, 244),
      appBar:AppBar(
        title:const Text('Photo Capture App',
        style: TextStyle(color: Colors.purple,
        fontSize: 26,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal),),
        centerTitle: true,
      ) ,
      body:Center(
      child: InkWell(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) =>const CameraScreen(),));
        },
        child: Container(
          width: 250,
          padding:const EdgeInsets.all(5),
          child:const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt,
              size: 40,
              color: Colors.purple,
              ),
              Text('Open Camera',
              style: TextStyle(
                fontSize: 24,
                color: Colors.purple
              ),),
            ],
          ),
        ),
      ),
      )
    );
  }
}
