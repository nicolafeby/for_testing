import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:for_testing/view/currency_test.dart';
import 'package:for_testing/view/pick_from_camera.dart';
import 'package:for_testing/view/pick_from_galerry.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        '/kamera': (context) => MyCameraPage(cameras: cameras),
        '/galeri': (context) => const PickFromGalery(),
        '/currency': (context) => const CurrencyTest(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/kamera');
              },
              child: const Text('Kamera'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/galeri');
              },
              child: const Text('Galeri'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/currency');
              },
              child: const Text('Currency'),
            ),
          ],
        ),
      ),
    );
  }
}
