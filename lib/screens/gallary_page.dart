import 'dart:io';

import 'package:camera_app2/screens/photoscreen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GallaryPage extends StatefulWidget {
  List<File> imagess;

  GallaryPage({
    super.key,
    required this.imagess,
  });

  @override
  State<GallaryPage> createState() => _GallaryPageState();
}

class _GallaryPageState extends State<GallaryPage> {
  String? _folderpath;
  Future<void> loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imageDir = Directory('${directory.path}/customgallery');
    final files = imageDir.listSync().whereType<File>();

    setState(() {
      images = files.toList();
      _folderpath = imageDir.toString();
    });
  }

  List<File> images = [];

  @override
  void initState() {
    loadImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gallery ',
          style: TextStyle(fontSize: 27),
        ),
        centerTitle: true,
      
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // const   TextField(
            //     keyboardType: TextInputType.datetime,
            //     decoration: InputDecoration(
            //         hintText: 'Search by date',
            //         hintStyle: TextStyle(color: Colors.grey),
            //         border: OutlineInputBorder()),
                    
            //   ),
           //   ElevatedButton(onPressed:(){} , child:const Icon(Icons.search) ),
            const SizedBox(
              height: 11,
            ),
            Expanded(
              child:
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                        mainAxisSpacing: 4),
                  itemCount: widget.imagess.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Photoscreen(image: images[index]);
                          },
                        )
                        );
                      
                      },
                      child: Container(
                        // padding:const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              
          
            ),
            Text(_folderpath.toString()),
          ],
        ),
      ),
    );
  }

}
