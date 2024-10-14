import 'package:flutter/material.dart';
import 'package:shopping/utils/common.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Favorites",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Text(
              "0 items as Favorites",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0, // Optional: Remove AppBar shadow for a cleaner look
      ),
      backgroundColor: Colors.white,
      body: const EmptyStateWidget(
        image: "assets/svg/empty/EmptyInbox.svg",
        title: "Favorites",
        subtitle: "No results found. Try again later.",
      ),
    );
  }
}
