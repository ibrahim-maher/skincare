import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/home_controller.dart';
import 'upload_photo_screen.dart'; // Replace with your actual screen for uploading photos
import 'view_report_screen.dart'; // Replace with your actual screen for viewing reports

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.tabIndex.value,
        children: [
          UploadPhotoScreen(),
          ViewReportScreen(),
        ],
      )),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
      onTap: controller.changeTabIndex,
      currentIndex: controller.tabIndex.value,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Upload Photo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'View Report',
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ));
  }
}
