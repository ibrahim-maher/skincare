import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoController extends GetxController {
  var selectedImagePath = ''.obs;

  final ImagePicker picker = ImagePicker();

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
}
