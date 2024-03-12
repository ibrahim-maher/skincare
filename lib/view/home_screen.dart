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
      appBar: AppBar(
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Implement your logout functionality here
                controller.logout();
                Navigator.pop(context); // Close the drawer
                // Assuming you have a named route for your login screen
                Navigator.pushReplacementNamed(context, '/onboarding');
              },
            ),
          ],
        ),
      ),
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
