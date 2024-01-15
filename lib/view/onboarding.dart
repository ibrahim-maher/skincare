import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_colors.dart';
import '../routes/app_routes.dart';


class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnboardingContent> onboardingPages = [
  OnboardingContent(
    image: 'assests/images/undraw_Upload_re_pasx.png', // Replace with your asset images
    title: 'Upload Your Image',
    description: 'Easily upload an image of your skin condition using our user-friendly interface.',
  ),
  OnboardingContent(
    image: 'assests/images/undraw_survey_05s5.png',
    title: 'Machine and Doctor Verification',
    description: 'Our advanced AI analyzes your image, followed by verification from certified doctors.',
  ),
  OnboardingContent(
    image: 'assests/images/undraw_details_8k13.png',
    title: 'View Your Report',
    description: 'Receive a comprehensive report about your skin condition, complete with doctor\'s recommendations.',
  ),
];


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingPages.length,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        itemBuilder: (_, index) {
          return OnboardingPageWidget(content: onboardingPages[index]);
        },
      ),
      bottomSheet: currentPage == onboardingPages.length - 1
          ? GestureDetector(
        onTap: () {
          Get.toNamed(Routes.SIGN_IN);
        },
        child: Container(
          color: AppColors.primaryColor,
          height: 80,
          alignment: Alignment.center,
          child: Text(
            'Get Started',
            style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
          ),
        ),
      )
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                _pageController.jumpToPage(onboardingPages.length - 1);
              },
              child: Text('SKIP', style: TextStyle(color: AppColors.secondaryColor)),
            ),
            Row(
              children: List.generate(onboardingPages.length, (index) => buildDot(index, context)),
            ),
            TextButton(
              onPressed: () {
                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
              },
              child: Text('NEXT', style: TextStyle(color: AppColors.secondaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentPage == index ? 30 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentPage == index ? AppColors.primaryColor : AppColors.tertiaryColor,
      ),
    );
  }
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPageWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child:Image.asset(content.image),

        ),
        SizedBox(height: 30),
        Text(
          content.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            content.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
