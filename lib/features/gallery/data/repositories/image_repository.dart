import 'dart:io';
import 'package:camera/camera.dart';

/// A repository class responsible for saving images to local storage.
class ImageRepository {

  /// Saves the captured image to the device's storage.
  ///
  /// Takes an [XFile] representing the captured image and returns a [Future<String>]
  /// that completes with the file path where the image has been saved.
  Future<String> saveImage(XFile image) async {
    // Get the Pictures directory in external storage
    Directory? directory = await _getPicturesDirectory();
    if (directory == null) {
      throw Exception("Could not get Pictures directory");
    }

    // Generate a unique file name based on the current timestamp
    String fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
    String filePath = '${directory.path}/$fileName';

    // Copy the captured image to the new file path
    await File(image.path).copy(filePath);

    // Return the path where the image has been saved
    return filePath;
  }

  /// Helper method to get the Pictures directory.
  Future<Directory?> _getPicturesDirectory() async {
    try {
      final Directory? picturesDirectory = Directory('/storage/emulated/0/Pictures');
      
      // Check if the directory exists asynchronously
      bool directoryExists = await picturesDirectory!.exists();
      if (directoryExists) {
        return picturesDirectory;
      } else {
        // If directory does not exist, create it
        return await picturesDirectory.create(recursive: true);
      }
    } catch (e) {
      print('Error accessing Pictures directory: $e');
      return null;
    }
  }
}
