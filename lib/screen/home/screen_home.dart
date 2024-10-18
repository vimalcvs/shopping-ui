import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping/models/model_product.dart';
import 'package:shopping/utils/common.dart';
import 'package:shopping/utils/item_list.dart';
import 'package:shopping/viewmodels/view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Category> categories = getCategories();
  final ProductViewModel _viewModel = ProductViewModel();
  final PageController _pageController = PageController();
  int _currentPosterIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _viewModel.fetchPoster();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_viewModel.posters.isNotEmpty) {
        setState(() {
          _currentPosterIndex =
              (_currentPosterIndex + 1) % _viewModel.posters.length;
        });
        _pageController.animateToPage(
          _currentPosterIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildToolBar(),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildPosterListView(),
            const SizedBox(height: 24),
            _buildCardSection(),
            const SizedBox(height: 24),
            _buildCategoryList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildToolBar() {
    return AppBar(
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
    );
  }

  Widget _buildPosterListView() {
    return SizedBox(
      height: 172,
      child: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          switch (_viewModel.uiState) {
            case UiState.loading:
              return const Center(child: CircularProgressIndicator());
            case UiState.error:
              return const Center(child: Text('Error loading posters'));
            case UiState.loaded:
              return _buildPostersListView();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildPostersListView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _viewModel.posters.length,
      itemBuilder: (context, index) {
        final poster = _viewModel.posters[index];
        return posterItem(poster);
      },
    );
  }

  Widget _buildCardSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCustomCard(Colors.blue),
            _buildCustomCard(Colors.red),
            _buildCustomCard(Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCard(Color color) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
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
    );
  }

  Widget _buildCategoryList() {
    final categories = getCategories();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0F0FF), Color(0x10FFFFFF), Color(0x00FFFFFF)],
          stops: [0.01, 0.02, 0.03],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryRow(category: categories[index]);
        },
      ),
    );
  }
}

class CategoryRow extends StatefulWidget {
  final Category category;

  const CategoryRow({super.key, required this.category});

  @override
  CategoryRowState createState() => CategoryRowState();
}

class CategoryRowState extends State<CategoryRow>
    with AutomaticKeepAliveClientMixin<CategoryRow> {
  final ProductViewModel _viewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchProducts(widget.category.id);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryTitle(),
        _buildProductList(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
          child: Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTitle() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.asset(
          widget.category.image,
          fit: BoxFit.fitHeight,
          width: 36,
          height: 36,
        ),
      ),
      title: Text(
        widget.category.title,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.category.subtitle,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return SizedBox(
      height: 240,
      child: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          switch (_viewModel.uiState) {
            case UiState.loading:
              return const Center(child: CircularProgressIndicator());
            case UiState.error:
              return const Center(child: Text('Error loading products'));
            case UiState.loaded:
              return _buildProductListView();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildProductListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _viewModel.products.length,
      itemBuilder: (context, index) {
        final product = _viewModel.products[index];
        return productItem(product);
      },
    );
  }
}
