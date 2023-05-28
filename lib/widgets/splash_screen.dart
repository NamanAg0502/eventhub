import 'package:eventhub/screens/auth/login_view.dart';
import 'package:eventhub/screens/menu/home_screen.dart';
import 'package:eventhub/screens/onboard/onboarding_view.dart';
import 'package:eventhub/widgets/indicators/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoginIn = false;
  bool isViewed = false;

  void checkIfViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool viewed = prefs.getBool('isViewed') ?? false;
    setState(() {
      isViewed = viewed;
    });
  }

  Future<void> checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool logged = prefs.getBool('login') ?? false;
    setState(() {
      isLoginIn = logged;
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfViewed();
    checkIfLoggedIn();
    // Simulate some loading time if needed
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the onboarding screens
      if (isViewed) {
        if (isLoginIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo/logo_name.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 2),
              const LoadingIndicator(),
            ],
          ),
        ));
  }
}
