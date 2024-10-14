import 'package:flutter/material.dart';
import 'package:shopping/utils/common.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Roasters",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              Text(
                "Discover our Roasters",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        iconTheme:
            const IconThemeData(color: Colors.black), // Ensures icons are black
      ),
      backgroundColor: Colors.white,
      body: const EmptyStateWidget(
        image: "assets/svg/empty/NoItemsCart.svg",
        title: "Your cart is empty",
        subtitle: "Check out what's trending",
      ),
    );
  }
}
