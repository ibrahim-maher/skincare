import 'package:get/get.dart';

class Report {
  String title;
  String description;

  Report({required this.title, required this.description});
}

class ViewReportController extends GetxController {
  var reports = <Report>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  void fetchReports() async {
    isLoading(true);
    try {
      // Fetch reports from the backend or database
      // For demonstration, using mock data
      await Future.delayed(Duration(seconds: 2)); // Mock delay
      reports.value = [
        Report(title: 'Report 1', description: 'Description of Report 1'),
        Report(title: 'Report 2', description: 'Description of Report 2'),
        // Add more mock reports or fetch from your backend
      ];
    } finally {
      isLoading(false);
    }
  }
}
