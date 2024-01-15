import 'package:get/get.dart';

import '../view/auth/doctor_sign_up_view.dart';
import '../view/auth/patient_sign_up_view.dart';
import '../view/onboarding.dart';
import '../view/auth/sign_in_screen.dart';
import '../view/auth/sign_up_screen.dart';
import '../view/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: Routes.SIGN_IN,
      page: () => SignInView(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => SignUpView(),
    ),
    GetPage(
      name: Routes.PATIENT_SIGN_UP,
        page: () => PatientSignUpView(),
    ),
    GetPage(
      name: Routes.DOCTOR_SIGN_UP,
      page: () => DoctorSignUpView(),
    ),
    // Add more GetPage instances as needed
  ];
}
