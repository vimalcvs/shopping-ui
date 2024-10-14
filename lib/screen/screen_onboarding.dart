import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/screen/screen_login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  final int totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: List.generate(totalPages, (index) {
                return _buildPage(index);
              }),
            ),
          ),
          _buildIndicator(),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    // Define your images, titles, and descriptions
    final List<Map<String, String>> pageData = [
      {
        'image': "assets/gifs/animation_1.json",
        'title': "Explore Service Providers",
        'description':
            "Whether it's a videographer, makeup artist or a meme agency, access 1000’s of top service providers.",
      },
      {
        'image': "assets/gifs/animation_2.json",
        'title': "Manage Your Projects",
        'description':
            "Easily organize and manage your ongoing and completed projects with top professionals.",
      },
      {
        'image': "assets/gifs/animation_3.json",
        'title': "Access Creative Services",
        'description':
            "Find the best creative professionals for your design and artistic needs.",
      },
    ];

    final page = pageData[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 52),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(page['image']!, height: 300),
          SizedBox(height: 20),
          Text(
            page['title']!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            page['description']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 10,
          width: (index == currentPage) ? 25 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: (index == currentPage) ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 100.0, left: 30.0, right: 30.0, top: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          if (currentPage == totalPages - 1) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onboardingComplete', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentPage == totalPages - 1 ? "Finish" : "Next",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              currentPage == totalPages - 1
                  ? Icons.check
                  : Icons.arrow_right_alt_rounded,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
