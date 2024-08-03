import 'package:camera/camera.dart';
import '../../data/repositories/image_repository.dart';

/// A class responsible for handling image capture operations.
class CaptureImage {
  final ImageRepository repository; // The repository used to save images

  /// Constructor to initialize the [CaptureImage] class with a repository.
  CaptureImage(this.repository);

  /// Saves the captured image using the provided [ImageRepository].
  ///
  /// Takes an [XFile] representing the captured image and returns a [Future<String>]
  /// that completes with the path where the image has been saved.
  Future<String> execute(XFile image) async {
    // Save the image using the repository and return the resulting file path
    return await repository.saveImage(image);
  }
}
