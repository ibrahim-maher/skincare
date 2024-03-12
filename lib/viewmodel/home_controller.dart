import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/signIn'); // Navigate the user to the login screen after logging out
    } catch (e) {
      Get.snackbar('Logout Error', 'Failed to log out: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
