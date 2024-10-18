import 'package:flutter/material.dart';
import 'package:shopping/models/model_product.dart';


class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              background: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ), Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 16.0),
                  Text(
                    'Price: \$${product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add to cart or any other action
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
