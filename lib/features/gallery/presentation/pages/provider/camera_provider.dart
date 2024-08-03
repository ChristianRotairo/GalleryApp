import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal_app/features/gallery/domain/usecases/capture_image.dart';
import '../../../data/models/image_model.dart';

class CameraProvider extends ChangeNotifier {
  final CaptureImage captureImageUseCase;
  List<ImageModel> _images = [];
  bool _isCapturing = false;
  final void Function(String message) showSnackbar;

  CameraProvider(this.captureImageUseCase, this.showSnackbar);

  List<ImageModel> get images => _images;
  bool get isCapturing => _isCapturing;

  Future<void> captureImage(CameraController controller) async {
    if (_isCapturing) return;

    _isCapturing = true;
    notifyListeners();

    try {
      final XFile image = await controller.takePicture();
      final String path = await captureImageUseCase.execute(image);
      _images.add(ImageModel(path: path, timestamp: DateTime.now()));

      showSnackbar('Image saved successfully!');
    } catch (e) {
      showSnackbar('Failed to save image.');
    } finally {
      _isCapturing = false;
      notifyListeners();
    }
  }

  void addCapturedImages(List<XFile> images) async {
    if (images.isNotEmpty) {
      _isCapturing = true;
      notifyListeners();

      try {
        for (var image in images) {
          final String path = await captureImageUseCase.execute(image);
          _images.add(ImageModel(path: path, timestamp: DateTime.now()));
        }
      } catch (e) {
        showSnackbar('Failed to save images.');
      } finally {
        _isCapturing = false;
        notifyListeners();
      }
    }
  }
}
