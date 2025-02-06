import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app2/main.dart';
import 'package:camera_app2/screens/gallary_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<File> images = [];

  String? capturedImagePath;
  late CameraController cameraController;
  @override
  void initState() {
    initializeCamera();
    loadImage();
    super.initState();
  }

  // initilizing camera
  Future<void> initializeCamera() async {
    if (cameras.isNotEmpty) {
      cameraController = CameraController(cameras[0], ResolutionPreset.high);
      try {
        await cameraController!.initialize();
        setState(() {});
      } catch (e) {
        debugPrint("error initializing");
      }
    } else {
      debugPrint("no camera avilable");
    }
  }

//load images
  Future<void> loadImage() async {
    final directory = await getDiroctory();
    final files = directory.listSync().whereType<File>();
    setState(() {
      images = files.toList();
    });
  }

//get imagedirectory

  Future<Directory> getDiroctory() async {
    final directory = await getApplicationDocumentsDirectory();
    final imageDir = Directory('${directory.path}/customgallery');
    if (!imageDir.existsSync()) {
      imageDir.createSync(recursive: true);
    }
    return imageDir;
  }

//capture image
  Future<void> captureImage() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    final permission = await Permission.camera.request();
    if (permission.isGranted) {
      try {
        final directory = await getDiroctory();
      final fileName = DateTime.now().toIso8601String();
        final path = '${directory.path}/$fileName.jpg';
        final XFile picture = await cameraController.takePicture();
        final savedImage = await File(picture.path).copy(path);

        setState(() {
          images.add(savedImage); // Use the actual saved path from the camera.
        });
        
      } catch (e) {
        debugPrint('Error capturing image: $e');
      }
    } else {
      dispose() {
        cameraController.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Camera',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            // width:double.infinity,
            height: double.infinity,
          child:  CameraPreview(cameraController),
          
          ),
          Positioned(
              bottom: 0,
              left: 180,
              child: IconButton(
                  onPressed: () async {
                    captureImage();
                  },
                  icon: const Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 70,
                  ))),
          Positioned(
              right: 0,
              bottom: 0,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return GallaryPage(
                          imagess: images,
                        );
                      },
                    ));
                  },
                  icon: const Icon(
                    Icons.photo_library,
                    color: Colors.white,
                    size: 70,
                  )))
        ],
      ),
    );
  }

  // Future<void> _captureImage() async {
  //   if (cameraController == null || !cameraController!.value.isInitialized) {
  //     return;
  //   }
  //   try {
  //     //capture the image
  //     final XFile imageFile = await cameraController.takePicture();

  //     final directory = await getApplicationDocumentsDirectory();
  //     final folderPath = '${directory}/custom';
  //     final customFolder = Directory(folderPath);
  //     if (customFolder.existsSync()) {
  //       customFolder.createSync(recursive: true);
  //     }
  //     final savedImagePath =
  //         '${customFolder.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     await imageFile.saveTo(savedImagePath);

  //       capturedImagePath = savedImagePath;

  //   } catch (e) {
  //     debugPrint('Error capturing image: $e');
  //   }

  // }
}
