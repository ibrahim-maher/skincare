import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/upload_photo_controller.dart';

class UploadPhotoScreen extends StatelessWidget {
  final UploadPhotoController controller = Get.put(UploadPhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected or captured image
            Obx(() {
              if (controller.isLoading.isTrue) {
                return CircularProgressIndicator();
              } else if (controller.selectedImagePath.value.isNotEmpty) {
                return Image.file(
                  File(controller.selectedImagePath.value),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                );
              } else {
                return Text('No image selected.');
              }
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.pickImage,
              child: Text('Select Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: controller.captureImage,
              child: Text('Capture Image from Camera'),
            ),
            SizedBox(height: 20),
            // Button to run inference on the selected image
            ElevatedButton(
              onPressed: () {
                if (controller.selectedImagePath.value.isNotEmpty) {
                  controller.runInference(controller.selectedImagePath.value);
                } else {
                  // Show an alert or a Snackbar if no image is selected
                  Get.snackbar("No Image", "Please select or capture an image first.");
                }
              },
              child: Text('Run Inference'),
            ),
            // Display inference results
            Obx(() {
              if (controller.inferenceResults.isNotEmpty) {
                return Text('Inference Results: ${controller.inferenceResults}');
              } else {
                return SizedBox.shrink(); // Empty space if no results
              }
            }),
          ],
        ),
      ),
    );
  }
}
