import 'package:eventhub/screens/onboard/onboarding_view.dart';
import 'package:eventhub/widgets/indicators/dots_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some loading time if needed
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the onboarding screens
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
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
