import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/model_product.dart';
import 'package:shopping/screen/home/screen_home.dart';
import 'package:shopping/utils/common.dart';
import 'package:shopping/viewmodels/view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Category> _categories = getCategories();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: PageContent(
        productViewModel: productViewModel,
        pageController: _pageController,
        categories: _categories,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 72,
      title: _buildAppBarTitle(),
      actions: _buildAppBarActions(),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  Column _buildAppBarTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello 👋",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text(
          getGreeting(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/svg/settings-sliders.svg",
              width: 22,
              height: 22,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    ];
  }
}

class PageContent extends StatelessWidget {
  final List<Category> categories;
  final PageController pageController;
  final ProductViewModel productViewModel;

  const PageContent({
    super.key,
    required this.categories,
    required this.pageController,
    required this.productViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          _buildImageSection(
            context,
            productViewModel,
            pageController,
          ),
          const SizedBox(height: 16),
          _buildCardSection(),
          const SizedBox(height: 16),
          _buildCategoryList(),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context,
      ProductViewModel productViewModel, PageController pageController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: PageView.builder(
          controller: pageController,
          itemCount: productViewModel.products.length,
          itemBuilder: (context, index) {
            final post = productViewModel.products[index];
            return PosterItem(post: post);
          },
        ),
      ),
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
                borderRadius: BorderRadius.circular(14),
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
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryRow(category: category);
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
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              widget.category.image,
              fit: BoxFit.fitHeight,
              width: 45,
              height: 45,
            ),
          ),
          title: Text(
            widget.category.title,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 16,
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
        ),
        SizedBox(
          height: 250,
          child: AnimatedBuilder(
            animation: _viewModel,
            builder: (context, _) {
              switch (_viewModel.uiState) {
                case UiState.loading:
                  return const Center(child: CircularProgressIndicator());
                case UiState.error:
                  return Center(
                    child: ErrorStateWidget(
                      image: 'assets/svg/empty/NoNetState.svg',
                      title: 'No internet connection!',
                      subtitle: 'Please check your internet connection.',
                      onRetry: () {
                        _viewModel.fetchProducts(widget.category.id);
                      },
                    ),
                  );
                case UiState.loaded:
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _viewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = _viewModel.products[index];
                      return SizedBox(
                        width: 190,
                        child: ProductCard(product: product),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  hideStatusBar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
