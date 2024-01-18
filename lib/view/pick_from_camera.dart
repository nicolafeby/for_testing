import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';

class MyCameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MyCameraPage({super.key, required this.cameras});

  @override
  State<MyCameraPage> createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.veryHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Example'),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            // Ambil gambar dari kamera
            XFile imageFile = await _controller.takePicture();

            // Baca informasi EXIF dari gambar
            Map<String, IfdTag> data =
                await readExifFromBytes(await imageFile.readAsBytes());

            // Tampilkan informasi EXIF
            showExifInfo(data);
          } catch (e) {
            print("Error: $e");
          }
        },
      ),
    );
  }

  void showExifInfo(Map<String, IfdTag> data) {
    if (data.isEmpty) {
      log("Tidak ada data EXIF ditemukan.");
    } else {
      log("Informasi EXIF:");
      data.forEach((tagName, tag) {
        log("$tagName (${tag.tagType}): ${tag.toString()}");
      });
    }
  }
}
