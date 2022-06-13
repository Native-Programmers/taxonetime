import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/models/onBoardModel.dart';
import 'package:taxonetime/screens/wrapper/wrapper.dart';
import 'package:taxonetime/widgets/onBoardScreenUI.dart';

bool isLastPage = false;

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/1.jpg',
      text: "Ease of Function",
      desc:
          "Become filer at the press of one button with the Hassle free system.",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/images/2.jpg',
      text: "No more amateur paper work",
      desc:
          "All cases are handled by trained professionals. Means no more hassle",
      bg: const Color(0xFF4756DF),
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/images/3.jpg',
      text: "Auto Reminders",
      desc: "To ensure people do not forget to file their statements",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          itemCount: screens.length,
          itemBuilder: (BuildContext context, int index) {
            return onBoardPageUI(index: index, screens: screens[index]);
          },
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                primary: Colors.white,
                backgroundColor: Colors.blueGrey.shade700,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('showHome', true);
                AuthController.authInstance.showHome.value = true;
                Get.offAll(const Wrapper());
              },
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.jumpToPage(2);
                      },
                      child: const Text('Skip')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black,
                        activeDotColor: Colors.blueGrey,
                      ),
                      onDotClicked: (index) {
                        pageController.animateToPage(index,
                            duration: const Duration(microseconds: 200),
                            curve: Curves.bounceIn);
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('Next')),
                ],
              )),
    );
  }
}
