class Product {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  List<String> tags;
  String brand;
  String sku;
  double weight;
  Dimensions dimensions;
  String warrantyInformation;
  String shippingInformation;
  String availabilityStatus;
  List<Review> reviews;
  String returnPolicy;
  int minimumOrderQuantity;
  Meta meta;
  List<String> images;
  String thumbnail;

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
      id: json['id'] ?? 0, // Default to 0 if 'id' is null
      title: json['title'] ??
          'No title', // Default to 'No title' if 'title' is null
      description: json['description'] ??
          'No description', // Default to 'No description'
      category: json['category'] ??
          'Unknown', // Default to 'Unknown' if 'category' is null
      price: (json['price'] != null)
          ? json['price'].toDouble()
          : 0.0, // Default to 0.0 if 'price' is null
      discountPercentage: (json['discountPercentage'] != null)
          ? json['discountPercentage'].toDouble()
          : 0.0,
      rating: (json['rating'] != null) ? json['rating'].toDouble() : 0.0,
      stock: json['stock'] ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      brand: json['brand'] ??
          'No brand', // Default to 'No brand' if 'brand' is null
      sku: json['sku'] ?? 'No SKU', // Default to 'No SKU' if 'sku' is null
      weight: (json['weight'] != null) ? json['weight'].toDouble() : 0.0,
      dimensions: Dimensions.fromJson(json['dimensions'] ?? {}),
      warrantyInformation: json['warrantyInformation'] ?? 'No warranty',
      shippingInformation: json['shippingInformation'] ?? 'No shipping info',
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown',
      reviews: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)))
          : [],
      returnPolicy: json['returnPolicy'] ?? 'No return policy',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,
      meta: Meta.fromJson(json['meta'] ?? {}),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      thumbnail:
          json['thumbnail'] ?? 'No thumbnail', // Default if 'thumbnail' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((x) => x.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

class Dimensions {
  double width;
  double height;
  double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] != null) ? json['width'].toDouble() : 0.0,
      height: (json['height'] != null) ? json['height'].toDouble() : 0.0,
      depth: (json['depth'] != null) ? json['depth'].toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}

class Review {
  int rating;
  String comment;
  String date;
  String reviewerName;
  String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? 'No comment',
      date: json['date'] ?? 'No date',
      reviewerName: json['reviewerName'] ?? 'Anonymous',
      reviewerEmail: json['reviewerEmail'] ?? 'No email',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class Meta {
  String createdAt;
  String updatedAt;
  String barcode;
  String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] ?? 'No creation date',
      updatedAt: json['updatedAt'] ?? 'No update date',
      barcode: json['barcode'] ?? 'No barcode',
      qrCode: json['qrCode'] ?? 'No QR code',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}
