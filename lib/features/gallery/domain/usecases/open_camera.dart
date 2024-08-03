// camera_controller.dart
import 'package:camera/camera.dart';

import '../../data/repositories/open_camera_repository.dart';


class CameraDomainController {
  final CameraRepository _repository;
  late CameraController controller;
  late Future<void> initializeFuture;
  List<CameraDescription> cameras;
  CameraDescription camera;
  int selectedCameraIndex = 0;
  bool isFlashOn = false;

  CameraDomainController(this._repository, this.cameras, this.camera);

  void initialize() {
    controller = CameraController(
      cameras[selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );
    initializeFuture = controller.initialize().catchError((e) {
      print('Error initializing camera: $e');
    });
  }

  void dispose() {
    controller.dispose();
  }

  void switchCamera() {
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    dispose();
    initialize();
  }

  void toggleFlash() {
    isFlashOn = !isFlashOn;
    controller.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
  }

  Future<List<String>> captureImage() async {
    try {
      await initializeFuture;
      final image = await controller.takePicture();
      return await _repository.saveImage(image);
    } catch (e) {
      print('Error capturing image: $e');
      return [];
    }
  }
}