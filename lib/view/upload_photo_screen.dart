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
            Obx(() {
              if (controller.selectedImagePath.value.isNotEmpty) {
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
              child: Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: controller.captureImage,
              child: Text('Capture Image'),
            ),
          ],
        ),
      ),
    );
  }
}
