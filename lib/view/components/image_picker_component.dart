import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'custom_button.dart';

class ImagePickerComponent extends StatefulWidget {
  @override
  _ImagePickerComponentState createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image != null ? Image.file(_image!) : Placeholder(fallbackHeight: 200.0),
        CustomButton(
          text: 'Pick Image',
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
