import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img; // Add this import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadPhotoController extends GetxController {
  var selectedImagePath = ''.obs;
  var isLoading = false.obs;
  var inferenceResults = <dynamic>[].obs;

  final List<String> labels = [
    'Eczema',
    'Warts Melanoma and other Viral Infections',
    'Melanoma',
    'Atopic Dermatitis',
    'Basal Cell Carcinoma',
    'Melanocytic Nevi (NV)',
    'Benign Keratosis-like Lesions (BKL)'
    'Psoriasis pictures Lichen Planus and related diseases',
    'Seborrheic Keratoses and other Benign Tumors ',
    'Tinea Ringworm Candidiasis and other Fungal Infection'
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
          img.Image resizedImage = img.copyResize(originalImage, width: 300, height: 300);

    // Convert the image to a byte list (RGB format) and normalize the values
          Uint8List imageBytes = resizedImage.getBytes(format: img.Format.rgb);

          var inputBuffer = Float32List(1 * 300 * 300 * 3);
          int bufferIndex = 0;
          for (int i = 0; i < imageBytes.length; i += 3) { //
            inputBuffer[bufferIndex++] = imageBytes[i] / 255.0;     // R
            inputBuffer[bufferIndex++] = imageBytes[i + 1] / 255.0; // G
            inputBuffer[bufferIndex++] = imageBytes[i + 2] / 255.0; // B
          }

    // Create a 4D tensor with shape [1, 300, 300, 3]
          var input = inputBuffer.buffer.asFloat32List().reshape([1, 300, 300, 3]);

          var output = List.filled(1 * 10, 0).reshape([1, 10]);  // Adjust the shape to match the model output

    // Run the model inference
          _interpreter!.run(input, output);

          var probabilities = output[0];

          // Find the index of the highest probability
          int highestProbIndex = 0;
          double highestProb = 0.0;
          print(probabilities);


          double maxValue = probabilities.reduce((double current, double next) => current > next ? current : next);
          int highestIndex = probabilities.indexOf(maxValue);

          print(highestIndex);

      //
      // for (int i = 0; i < probabilities.length; i++) {
      //   // print(probabilities[i]);
      //   print(highestProb);
      //   if (probabilities[i] > highestProb) {
      //     highestProb = probabilities[i];
      //     highestProbIndex = i;
      //   }
      // }

      // Map the index to a label
      print(highestIndex);


      String predictedLabel = labels[highestIndex];
      String imageUrl = await uploadImageToStorage(path);
      await saveReportToFirestore(imageUrl, predictedLabel);
      print("Predicted Label: $predictedLabel");


      inferenceResults.value = [predictedLabel] ;
    } catch (e) {
      print("Error running model inference: $e");
    } finally {
      isLoading.value = false;
    }
  }



  Future<String> uploadImageToStorage(String imagePath) async {
    File imageFile = File(imagePath);
    String fileName = 'reports/${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> saveReportToFirestore(String imageUrl, String predictedLabel) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentReference docRef = FirebaseFirestore.instance.collection('report').doc();

      await docRef.set({
        'userId': currentUser.uid,
        'imageUrl': imageUrl,
        'predictedLabel': predictedLabel,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      print("No authenticated user found!");
    }
  }


  @override
  void onClose() {
    _interpreter?.close();
    super.onClose();
  }
}
