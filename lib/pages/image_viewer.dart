import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl,petName;

  const ImageViewer({super.key, required this.imageUrl,required this.petName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(petName),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.asset(imageUrl),
        ),
      ),
    );
  }
}