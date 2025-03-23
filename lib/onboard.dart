
import 'package:flutter/material.dart';

import 'homepage.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Accurate Carbon Measurement",
      "description": "Track and analyze your carbon emissions with precision.",
      "image": "assets/onb3.webp",
    },
    {
      "title": "Refer Friends & Earn Bonus",
      "description": "Invite friends and earn reward points for referrals.",
      "image": "assets/onb1.webp",
    },
    {
      "title": "Get Discounts for Green Actions",
      "description": "Reduce your carbon footprint and unlock exclusive discounts.",
      "image": "assets/onb2.webp",
    },
  ];

  void _nextPage() {
    if(_currentPage < onboardingData.length -1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => OnboardingPage(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                image: onboardingData[index]["image"]!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => buildDot(index),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text(
              _currentPage == onboardingData.length - 1 ? "Finish" : "Got It!",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: _currentPage == index ? 12 : 8,
      height: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title, description, image;

  const OnboardingPage({super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.cover, // Makes the image fill the space
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}