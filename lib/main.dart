import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/model_product.dart';
import 'package:shopping/screen/screen_detail.dart';
import 'package:shopping/screen/screen_login.dart';
import 'package:shopping/screen/screen_main.dart';
import 'package:shopping/screen/screen_onboarding.dart';
import 'package:shopping/screen/screen_splash.dart';
import 'package:shopping/utils/common.dart';
import 'package:shopping/viewmodels/view_model.dart';

void main() {
  hideStatusBar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductViewModel()..fetchProducts('smartphones'),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Shopping',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpVerificationScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final product = state.extra as Product;
        return DetailScreen(product: product);
      },
    ),
  ],
);
