import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../utilities/colors.dart';
import '../provider/camera_provider.dart';
import 'open_camera_page.dart';

class CamPage extends StatelessWidget {
  final List<CameraDescription> cameras;
  const CamPage({Key? key, required this.cameras}) : super(key: key);

  // Permission Access
  Future<void> _checkPermissionAndCapture(BuildContext context) async {
    var cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      await _openCamera(context);
    } else if (cameraStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied')),
      );
    } else if (cameraStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    final List<XFile>? images = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(cameras: cameras, camera: cameras[0]),
      ),
    );
    if (images != null && images.isNotEmpty) {
      // Use CameraProvider to add captured images
      final cameraProvider = Provider.of<CameraProvider>(context, listen: false);
      cameraProvider.addCapturedImages(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title:  const Text(
            "Camera",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
        
          ),
        ),
      ),
      body: Consumer<CameraProvider>(
        builder: (context, cameraProvider, child) {
          return ListView.builder(
            itemCount: cameraProvider.images.length,
            itemBuilder: (context, index) {
              final image = cameraProvider.images[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0, right: 10),
        child: FloatingActionButton(
          onPressed: () => _checkPermissionAndCapture(context),
          child: const Icon(Icons.camera_alt_rounded),
        ),
      ),
    );
  }
}