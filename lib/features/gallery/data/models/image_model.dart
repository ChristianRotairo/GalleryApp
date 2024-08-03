/// A model class representing an image with its metadata.
class ImageModel {
  /// The file path where the image is stored.
  final String path;

  /// The timestamp indicating when the image was captured.
  final DateTime timestamp;

  /// Creates an instance of [ImageModel] with the specified [path] and [timestamp].
  ///
  /// [path] is the file path of the image.
  /// [timestamp] is the date and time when the image was captured.
  ImageModel({required this.path, required this.timestamp});
}
