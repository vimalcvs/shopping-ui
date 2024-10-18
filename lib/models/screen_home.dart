import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/model_product.dart';
import 'package:shopping/utils/common.dart';
import 'package:shopping/viewmodels/view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: SvgPicture.asset(
              "assets/svg/search.svg",
              width: 22,
              height: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg/settings-sliders.svg",
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello 👋",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 24)),
            Text(
              getGreeting(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF000000),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: productViewModel.uiState == UiState.loading
          ? const Center(child: ShimmerHomeLoading())
          : productViewModel.uiState == UiState.error
              ? Center(
                  child: ErrorStateWidget(
                    image: 'assets/svg/empty/NoNetState.svg',
                    title: 'No internet connection!',
                    subtitle: 'Please check your internet connection.',
                    onRetry: () {
                      productViewModel.fetchProducts('smartphones');
                    },
                  ),
                )
              : ScreenHomeList(productViewModel: productViewModel),
    );
  }
}

class ScreenHomeList extends StatefulWidget {
  final ProductViewModel productViewModel;

  const ScreenHomeList({super.key, required this.productViewModel});

  @override
  ScreenHomeListState createState() => ScreenHomeListState();
}

class ScreenHomeListState extends State<ScreenHomeList> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.productViewModel.products.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.productViewModel.products.length,
              itemBuilder: (context, index) {
                final post = widget.productViewModel.products[index];
                return PosterItem(post: post);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Hello",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Hello",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Hello",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE0F0FF),
                Color(0x10FFFFFF),
                Color(0x00ffffff),
              ],
              stops: [0.01, 0.02, 0.03],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: [
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Beauty",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Fragrances",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Furniture",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Groceries",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Home Decoration",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Kitchen Accessories",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Laptops",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Mens Shirts",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Mens Shoes",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Mens Shoes",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Mens Watches",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Mobile Accessories",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
              ProductList(
                  productViewModel: widget.productViewModel,
                  title: "Motorcycle",
                  subtitle: "Products List",
                  image: "assets/icon/offer_default_icon.png"),
            ],
          ),
        ),
      ],
    );
  }
}

class PosterItem extends StatelessWidget {
  final Product post;

  const PosterItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              post.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              post.title,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final ProductViewModel productViewModel;
  final String title;
  final String subtitle;
  final String image;

  const ProductList({
    super.key,
    required this.productViewModel,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(
                  image,
                  width: 35,
                  height: 35,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                // Removed const here
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      // const can be used here since style is constant
                      color: Colors.black,

                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 230,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: productViewModel.products.length,
            itemBuilder: (context, index) {
              final product = productViewModel.products[index];
              return ProductCard(product: product);
            },
          ),
        ),
        const SizedBox(height: 34),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 3.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 0,
        color: Colors.white,
        // Set card color to white
        margin: const EdgeInsets.only(left: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFFE1E1E1),
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  product.thumbnail,
                  fit: BoxFit.fitHeight,
                  height: 120,
                  width: double.infinity,
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${product.discountPercentage}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$${(product.price / (1 - product.discountPercentage / 100)).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 12),
                      const SizedBox(width: 5),
                      Text(
                        product.availabilityStatus,
                        style: TextStyle(
                            color: product.availabilityStatus == "Low Stock"
                                ? Colors.red
                                : Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
