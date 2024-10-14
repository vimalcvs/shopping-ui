import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/model_product.dart';
import 'package:shopping/utils/common.dart';
import 'package:shopping/viewmodels/view_model.dart';
import 'dart:async';

class Category {
  final String id;
  final String title;
  final String subtitle;
  final String image;

  Category({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<Category> getCategoriesList() {
  return [
    Category(
      id: "beauty",
      title: "Beauty",
      subtitle: "Skincare and cosmetics",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "furniture",
      title: "Furniture",
      subtitle: "Home and office furniture",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "laptops",
      title: "Laptops",
      subtitle: "Portable computers",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "mens-shirts",
      title: "Men's Shirts",
      subtitle: "Stylish and casual shirts",
      image: "assets/icon/offer_default_icon.png",
    ),
  ];
}

void main() {
  hideStatusBar();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Product App'),
        ),
        body: const ProductListPage(),
      ),
    ),
  );
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Category> categories = getCategoriesList();
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize with the first category
    selectedCategory = categories.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = ProductViewModel();
        viewModel.fetchProducts(selectedCategory);  // Fetch products for selected category
        viewModel.fetchPoster();
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ProductViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildCategoryList(),
                  const SizedBox(height: 20),
                  _buildContent(viewModel),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category.id;
              });
              Provider.of<ProductViewModel>(context, listen: false).fetchProducts(selectedCategory);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(category.image),
                    radius: 30,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selectedCategory == category.id
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(ProductViewModel viewModel) {
    switch (viewModel.uiState) {
      case UiState.loading:
        return const ShimmerBookmarkLoading();
      case UiState.error:
        return _buildErrorState(viewModel);
      case UiState.loaded:
      default:
        return _buildProductList(viewModel);
    }
  }

  Widget _buildErrorState(ProductViewModel viewModel) {
    return ErrorStateWidget(
      image: 'assets/svg/empty/NoNetState.svg',
      title: 'No internet connection!',
      subtitle: 'Please check your internet connection.',
      onRetry: () {
        viewModel.fetchPoster();
        viewModel.fetchProducts(selectedCategory);
      },
    );
  }

  Widget _buildProductList(ProductViewModel viewModel) {
    return Column(
      children: [
        _buildHorizontalProductList(viewModel),
        const SizedBox(height: 20),
        _buildVerticalProductList(viewModel),
      ],
    );
  }

  Widget _buildHorizontalProductList(ProductViewModel viewModel) {
    PageController pageController = PageController();
    int currentPage = 0;
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < viewModel.products.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    return SizedBox(
      height: 220,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController,
        itemCount: viewModel.products.length,
        itemBuilder: (context, index) {
          final poster = viewModel.products[index];
          return _buildProductCard(poster);
        },
      ),
    );
  }

  Widget _buildProductCard(Product poster) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Card(
          color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.network(poster.thumbnail, width: 100, height: 140),
              const SizedBox(height: 8),
              Text(poster.title),
            ],
          ),
        ));
  }

  Widget _buildVerticalProductList(ProductViewModel viewModel) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: viewModel.posters.length,
      itemBuilder: (context, index) {
        final product = viewModel.posters[index];
        return _buildVerticalListItem(product);
      },
    );
  }

  Widget _buildVerticalListItem(Product product) {
    return ListTile(
      leading: Image.network(product.thumbnail, height: 200),
      title: Text(product.title),
    );
  }
}
