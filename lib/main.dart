import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
