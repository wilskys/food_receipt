import 'package:flutter/material.dart';
import 'package:food_receipt/config/app_colors.dart';
import 'package:food_receipt/features/splash_screen/widgets/bottom_curve_clipper.dart';
import 'package:food_receipt/features/splash_screen/widgets/start_button.dart';
import '../../config/app_text_styles.dart';
import 'widgets/page_indicator.dart';
import 'widgets/arrow_button.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> splashData = [
    {
      'image': 'assets/image/splash/splash-1.jpg',
      'title': 'Huge Recipe Collection',
      'description':
          'Explore over 4,000 delicious halal recipes.\n'
          'Each dish is thoughtfully curated from diverse\n'
          'Muslim communities, offering global flavor.',
    },
    {
      'image': 'assets/image/splash/splash-2.jpg',
      'title': 'Cook With Confidence',
      'description':
          'Step-by-step instructions with clear ingredients\n'
          'to help you cook tasty meals every day.',
    },
    {
      'image': 'assets/image/splash/splash-3.png',
      'title': 'Save Your Favorites',
      'description':
          'Bookmark your favorite recipes and access them\n'
          'anytime even without internet connection.',
    },
  ];

  void _nextPage() {
    if (_currentIndex < splashData.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: Navigate to Home
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLastPage = _currentIndex == splashData.length - 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            /// IMAGE (NO SWIPE)
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: _pageController,
                itemCount: splashData.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (_, index) {
                  return ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Image.asset(
                      splashData[index]['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            /// TEXT + ACTION
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    Text(
                      splashData[_currentIndex]['title']!,
                      style: TextStyle(
                        fontSize: screenWidth * 0.07, // responsive
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      splashData[_currentIndex]['description']!,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ArrowButton(
                          direction: ArrowDirection.back,
                          enabled: _currentIndex > 0,
                          onTap: _prevPage,
                        ),

                        PageIndicator(
                          currentIndex: _currentIndex,
                          total: splashData.length,
                        ),

                        isLastPage
                            ? StartButton()
                            : ArrowButton(
                                direction: ArrowDirection.next,
                                onTap: _nextPage,
                              ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
