import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img; // Add this import


class UploadPhotoController extends GetxController {
  var selectedImagePath = ''.obs;
  var isLoading = false.obs;
  var inferenceResults = <dynamic>[].obs;

  final List<String> labels = [
    'Basal cell carcinoma', // bcc
    'Actinic keratoses ', // akiec

    'Benign keratosis-like lesions', // bkl
    'Dermatofibroma', // df
    'Melanocytic nevi', // nv
    'Pyogenic granulomas and hemorrhage', // vasc
    'Melanoma' // mel
  ];

  final ImagePicker picker = ImagePicker();
  Interpreter? _interpreter;

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  Future<void> loadModel() async {
    isLoading.value = true;

    try {
      _interpreter = await Interpreter.fromAsset('assests/model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print("Error loading model: $e");
      print('Make sure the model file is added to pubspec.yaml under assets');
      print('Also ensure the model file is a valid TensorFlow Lite model');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }


  Future<void> runInference(String path) async {
    if (_interpreter == null) {
      print("Interpreter not initialized");
      return;
    }
    isLoading.value = true;

    try {
      img.Image? originalImage = img.decodeImage(File(path).readAsBytesSync());
      if (originalImage == null) {
        print("Unable to decode image");
        return;
      }
      img.Image resizedImage = img.copyResize(originalImage, width: 28, height: 28);

      // Convert the image to a byte list (RGB format) and normalize the values
      Uint8List imageBytes = resizedImage.getBytes(format: img.Format.rgb);

      var inputBuffer = Float32List(1 * 28 * 28 * 3);
      int bufferIndex = 0;
      for (int i = 0; i < imageBytes.length; i += 4) {
        inputBuffer[bufferIndex++] = imageBytes[i] / 255.0;     // R
        inputBuffer[bufferIndex++] = imageBytes[i + 1] / 255.0; // G
        inputBuffer[bufferIndex++] = imageBytes[i + 2] / 255.0; // B
      }

      // Create a 4D tensor with shape [1, 28, 28, 3]
      var input = inputBuffer.buffer.asFloat32List().reshape([1, 28, 28, 3]);

      var output = List.filled(1 * 7, 0).reshape([1, 7]);  // Adjust the shape to match the model output

      // Run the model inference
      _interpreter!.run(input, output);

      var probabilities = output[0]; // Assuming output is in the nested list format

      // Find the index of the highest probability
      int highestProbIndex = 0;
      double highestProb = 0.0;
      for (int i = 0; i < probabilities.length; i++) {
        if (probabilities[i] > highestProb) {
          highestProb = probabilities[i];
          highestProbIndex = i;
        }
      }

      // Map the index to a label
      String predictedLabel = labels[highestProbIndex];
      print("Predicted Label: $predictedLabel");


      inferenceResults.value = [predictedLabel] ;
    } catch (e) {
      print("Error running model inference: $e");
    } finally {
      isLoading.value = false;
    }
  }






  @override
  void onClose() {
    _interpreter?.close();
    super.onClose();
  }
}
