class ProductModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final double price;
  final int stock;
  final String imageUrl;
  final int categoryId;

  const ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.categoryId,
  });

  static double _parseDouble(dynamic val) {
    if (val == null) return 0.0;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0.0;
    return 0.0;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      nameEn: json['name_en'] ?? json['nameEn'] ?? "",
      nameAr: json['name_ar'] ?? json['nameAr'] ?? "",
      descriptionEn: json['description_en'] ?? json['descriptionEn'] ?? "",
      descriptionAr: json['description_ar'] ?? json['descriptionAr'] ?? "",
      price: _parseDouble(json['price']),
      stock: json['stock'] ?? 0,
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? "",
      categoryId: json['category_id'] ?? json['categoryId'] ?? 0,
    );
  }
}
