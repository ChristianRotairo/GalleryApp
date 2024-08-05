import 'package:flutter/material.dart';
import '../../../../utilities/colors.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Gallery",
         style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        )),
        backgroundColor: backgroundColor,
      ),
      backgroundColor: const Color.fromRGBO(33, 17, 52, 1),
      
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Text(
            "No Images to Display",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 99, 99, 99),
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }
}
