import 'package:flutter/material.dart';
import 'package:shopping/models/model_product.dart';

Widget posterItem(Product product) {
  return Card(
    elevation: 1,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(
        color: Color(0xFFE1E1E1),
        width: 0.2,
      ),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            product.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            product.title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

Widget productItem(Product product) {
  return SizedBox(
    width: 190,
    child: Card(
      elevation: 0.5,
      color: Colors.white,
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
                top: 5,
                right: 5,
                child: Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 16,
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  top: 5,
                  right: 5,
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
                const SizedBox(height: 8),
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
