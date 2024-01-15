import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/view_report_controller.dart';

class ViewReportScreen extends StatelessWidget {
  final ViewReportController controller = Get.put(ViewReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Reports'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.reports.isEmpty) {
          return Center(child: Text('No reports available.'));
        }

        return ListView.builder(
          itemCount: controller.reports.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.reports[index].title),
              subtitle: Text(controller.reports[index].description),
              // Add additional report details here
            );
          },
        );
      }),
    );
  }
}
