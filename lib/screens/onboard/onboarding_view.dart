import 'package:eventhub/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  Future<void> _updateOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('shownOnboarding', true);
  }

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: ' Explore Upcoming and Nearby Events ',
      description:
          ' In publishing and graphic design, Lorem is a placeholder text commonly ',
      imageUrl: 'assets/images/onboard/1.png',
    ),
    OnboardingModel(
      title: ' Web Have Modern Events Calendar Feature',
      description:
          ' In publishing and graphic design, Lorem is a placeholder text commonly ',
      imageUrl: 'assets/images/onboard/2.png',
    ),
    OnboardingModel(
      title: 'To Look Up More Events or Activities Nearby By Map',
      description:
          ' In publishing and graphic design, Lorem is a placeholder text commonly ',
      imageUrl: 'assets/images/onboard/3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final onboarding = _pages[index];
          return OnboardingPage(
            title: onboarding.title,
            description: onboarding.description,
            imageUrl: onboarding.imageUrl,
            onNext: _goToNextPage,
            onSkip: _skipOnboarding,
            isLastPage: index == _pages.length - 1,
            currentPageIndex: _currentPageIndex,
            pageCount: _pages.length,
          );
        },
      ),
    );
  }

  void _goToNextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _updateOnboardingStatus();
      // Navigate to the login/register screens
      _navigateToLoginScreen();
    }
  }

  void _skipOnboarding() {
    _updateOnboardingStatus();
    // Navigate to the login/register screens
    _navigateToLoginScreen();
  }

  void _navigateToLoginScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool shownOnboarding = prefs.getBool('shownOnboarding') ?? false;
    if (shownOnboarding) {
      // Onboarding already shown, navigate to the login/register screens
      _navigateToLoginScreen();
    }
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final bool isLastPage;
  final int currentPageIndex;
  final int pageCount;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onNext,
    required this.onSkip,
    required this.isLastPage,
    required this.currentPageIndex,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.56,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.34,
              decoration: const BoxDecoration(
                  color: Color(0xff5669FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  )),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 32),
                              isLastPage
                                  ? const SizedBox()
                                  : Expanded(
                                      child: TextButton(
                                        onPressed: onSkip,
                                        child: const Text('Skip',
                                            style: TextStyle(
                                              color: Colors.white60,
                                            )),
                                      ),
                                    ),
                              isLastPage
                                  ? const SizedBox()
                                  : Row(
                                      children: [
                                        for (int i = 0; i < pageCount; i++)
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            width: 8.0,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: i == currentPageIndex
                                                  ? Colors.white
                                                  : Colors.white24,
                                            ),
                                          ),
                                      ],
                                    ),
                              Expanded(
                                child: TextButton(
                                  onPressed: onNext,
                                  child: Text(
                                      isLastPage ? 'Get Started' : 'Next',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(width: 32),
                            ],
                          ))
                    ]),
              ))
        ],
      ),
    ));
  }
}
