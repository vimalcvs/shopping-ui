import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/model_product.dart';
import 'package:shopping/utils/common.dart';
import 'package:shopping/viewmodels/view_model.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final uiState = productViewModel.uiState;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Center(
          child: Column(
            children: [
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: _buildBody(uiState, productViewModel),
    );
  }

  Widget _buildBody(UiState uiState, ProductViewModel viewModel) {
    if (uiState == UiState.loading) {
      return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return const ShimmerBookmarkLoading();
        },
      );
    } else if (uiState == UiState.error) {
      return Center(
        child: ErrorStateWidget(
          image: 'assets/svg/empty/NoNetState.svg',
          title: 'No internet connection!',
          subtitle: 'Please check your internet connection.',
          onRetry: () {
            viewModel.fetchProducts('smartphones');
          },
        ),
      );
    } else if (viewModel.products.isEmpty) {
      return const Center(
        child: Text(
          'No bookmarked products available.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: viewModel.products.length,
        itemBuilder: (context, index) {
          final product = viewModel.products[index];
          return ListBookmark(product: product);
        },
      );
    }
  }
}

class ListBookmark extends StatelessWidget {
  final Product product;

  const ListBookmark({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      onTap: () {},
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(
          product.thumbnail,
          fit: BoxFit.cover,
          height: 60,
          width: 60,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, size: 60, color: Colors.grey);
          },
        ),
      ),
      title: Text(
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        product.shippingInformation,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      tileColor: Colors.white,
      shape: const Border(
        bottom: BorderSide(color: Colors.grey, width: 0.2),
      ),
    );
  }
}
