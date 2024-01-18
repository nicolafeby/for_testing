import 'dart:developer';

import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickFromGalery extends StatefulWidget {
  const PickFromGalery({super.key});

  @override
  State<PickFromGalery> createState() => _PickFromGaleryState();
}

class _PickFromGaleryState extends State<PickFromGalery> {
  Uint8List? _imageBytes;
  late Map<String, IfdTag> _exifData;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
        _readExifData();
      });
    }
  }

  Future<void> _readExifData() async {
    try {
      _exifData = await readExifFromBytes(_imageBytes!);
      showExifInfo(_exifData);
    } catch (e) {
      log("Error reading EXIF data: $e");
    }
  }

  void showExifInfo(Map<String, IfdTag> data) {
    if (data.isEmpty) {
      log("No EXIF data found.");
    } else {
      log("EXIF Information:");
      data.forEach((tagName, tag) {
        log("$tagName (${tag.tagType}): ${tag.toString()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EXIF Reader"),
      ),
      body: Center(
        child: _imageBytes != null
            ? Image.memory(
                _imageBytes!,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              )
            : Text("No Image Selected"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageFromGallery,
        tooltip: 'Pick Image',
        child: Icon(Icons.photo),
      ),
    );
  }
}