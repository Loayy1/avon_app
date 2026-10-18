class CartItemModel {
  final int productId;
  final String name;
  final String? description;
  final String imageUrl;
  final double price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  static double _parseDouble(dynamic val) {
    if (val == null) return 0.0;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic val, {int defaultValue = 0}) {
    if (val == null) return defaultValue;
    if (val is int) return val;
    if (val is num) return val.toInt();
    if (val is String) return int.tryParse(val) ?? defaultValue;
    return defaultValue;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = (json["product"] ?? json["Product"]) as Map<String, dynamic>?;

    final id = _parseInt(
      json["productId"] ??
          json["product_id"] ??
          json["id"] ??
          product?["id"] ??
          product?["productId"],
    );

    final name = (product?["name_en"] ??
            product?["nameEn"] ??
            product?["name"] ??
            json["name_en"] ??
            json["nameEn"] ??
            json["name"] ??
            "")
        .toString();

    final desc = (product?["description_en"] ??
            product?["descriptionEn"] ??
            product?["description"] ??
            json["description_en"] ??
            json["descriptionEn"] ??
            json["description"])
        ?.toString();

    final image = (product?["image_url"] ??
            product?["imageUrl"] ??
            json["image_url"] ??
            json["imageUrl"] ??
            "")
        .toString();

    final itemPrice = _parseDouble(
      product?["price"] ?? json["price"] ?? json["unitPrice"],
    );

    final qty = _parseInt(json["quantity"] ?? json["count"], defaultValue: 1);

    return CartItemModel(
      productId: id,
      name: name,
      description: desc,
      imageUrl: image,
      price: itemPrice,
      quantity: qty > 0 ? qty : 1,
    );
  }
}
