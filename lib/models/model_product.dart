class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      tags: List<String>.from(json['tags']),
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'].toDouble(),
      dimensions: Dimensions.fromJson(json['dimensions']),
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews:
          List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: Meta.fromJson(json['meta']),
      images: List<String>.from(json['images']),
      thumbnail: json['thumbnail'],
    );
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      depth: json['depth'].toDouble(),
    );
  }
}

class Review {
  final double rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}

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

List<Category> getCategories() {
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
    Category(
      id: "mens-shoes",
      title: "Men's Shoes",
      subtitle: "Footwear for men",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "mens-watches",
      title: "Men's Watches",
      subtitle: "Timeless accessories",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "mobile-accessories",
      title: "Mobile Accessories",
      subtitle: "Covers, chargers, and more",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "motorcycle",
      title: "Motorcycle",
      subtitle: "Motorcycles and gear",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "skin-care",
      title: "Skin Care",
      subtitle: "Treatments for healthy skin",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "sunglasses",
      title: "Sunglasses",
      subtitle: "Stylish eyewear",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "tablets",
      title: "Tablets",
      subtitle: "Portable touch screen devices",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "womens-bags",
      title: "Women's Bags",
      subtitle: "Fashionable bags for women",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "womens-shoes",
      title: "Women's Shoes",
      subtitle: "Footwear for women",
      image: "assets/icon/offer_default_icon.png",
    ),
    Category(
      id: "womens-watches",
      title: "Women's Watches",
      subtitle: "Elegant timepieces",
      image: "assets/icon/offer_default_icon.png",
    ),
  ];
}
