import 'package:camera/camera.dart';
import 'package:camera_app2/screens/home_screen.dart';
import 'package:flutter/material.dart';
  late  List <CameraDescription> cameras ;
Future< void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras =  await availableCameras();
  runApp(const MyApp());
  
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          color:  Color.fromARGB(255, 232, 159, 245),
          foregroundColor: Colors.purple,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        
        useMaterial3: true,
      ),
      home:const HomeScreen(),
    );
  }
}

