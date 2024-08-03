// camera_repository.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';


// Save the image to application storage 
//locate in /storage/Android/data/com.example.gal_app/files
class CameraRepository {
  Future<List<String>> saveImage(XFile image) async {
    try {
      Directory? downloadsDirectory = await getExternalStorageDirectory();
      String downloadsPath = downloadsDirectory?.path ?? (await getApplicationDocumentsDirectory()).path;

      String fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
      String filePath = '$downloadsPath/$fileName';

      await File(image.path).copy(filePath);

      return [filePath];
    } catch (e) {
      print('Error saving image: $e');
      return [];
    }
  }
}