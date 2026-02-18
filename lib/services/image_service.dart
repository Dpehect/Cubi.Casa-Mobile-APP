import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';

class ImageService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<File>> pickMultipleImages() async {
    try {
      final pickedFiles = await _imagePicker.pickMultiImage();
      return pickedFiles.map((file) => File(file.path)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> compressImage(String imagePath) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        imagePath,
        imagePath.replaceAll('.jpg', '_compressed.jpg'),
        quality: 80,
        minHeight: 1024,
        minWidth: 1024,
      );
      return result != null ? File(result.path) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getImageProperties(File imageFile) async {
    try {
      final size = await imageFile.length();
      final path = imageFile.path;
      final lastModified = await imageFile.lastModified();

      return {
        'size': size,
        'path': path,
        'lastModified': lastModified,
        'fileName': path.split('/').last,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> cropImage(String imagePath) async {
    try {
      return File(imagePath);
    } catch (e) {
      rethrow;
    }
  }
}
