import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

String urlApi() {
  return 'https://dummyjson.com/';
}

String getFirstThreeWords(String text) {
  return text.split(' ').take(3).join(' ');
}

String getGreeting() {
  var hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image in the center
          SvgPicture.asset(
            image,
            width: 180,
            height: 180,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image in the center
          SvgPicture.asset(
            image,
            width: 180,
            height: 180,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerBookmarkLoading extends StatelessWidget {
  const ShimmerBookmarkLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            // Rounded image container
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rounded text shape 1
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    width: 200,
                    height: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Rounded text shape 2
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    width: 150,
                    height: 8,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerHomeLoading extends StatelessWidget {
  const ShimmerHomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap the entire content in a SingleChildScrollView for vertical scrolling
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 90,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: 8,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ])),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 90,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: 8,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ])),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 90,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: 8,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ])),
                ],
              ),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x4CFFFFFF),
                  Color(0x00000000),
                  Color(0x00000000),
                ],
                stops: [0.01, 0.05, 0.08],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
            ),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children: [
                    const SizedBox(height: 8.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    height: 10,
                                    width: 180,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    height: 10,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ])
                        ]),
                  ])),
              // First horizontal scrollable row
              const SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Repeated section
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children: [
                    const SizedBox(height: 16.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    height: 10,
                                    width: 180,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    height: 10,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ])
                        ]),
                  ])),
              const SizedBox(height: 12.0),
              // Second horizontal scrollable row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Another repeated section
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children: [
                    const SizedBox(height: 16.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    height: 10,
                                    width: 180,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    height: 10,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ])
                        ]),
                  ])),
              const SizedBox(height: 12.0),
              // Third horizontal scrollable row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 210,
                        width: 170,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
            ]),
          ),
        ]),
      ),
    );
  }
}

void hideStatusBar() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
